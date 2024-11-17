import 'package:logger/logger.dart';
import 'package:wave_odc/config/app_provider.dart';
import 'package:wave_odc/models/api_reponse.dart';
import 'package:wave_odc/providers/cache_provider.dart';
import 'package:wave_odc/services/auth/token_service.dart';
import 'package:wave_odc/services/provider/interfaces/IApiService.dart';
import 'package:wave_odc/services/auth/user_auth_service.dart';

class AuthService {
  final logger = Logger();
  late IApiService _apiService;
  late TokenService _tokenService;
  late UserAuthService _userAuthService;
  late CacheProvider _cache;

  AuthService() {
    _apiService = locator<IApiService>(param1: "/auth");
    _tokenService = locator<TokenService>();
    _userAuthService = locator<UserAuthService>();
    _cache = locator<CacheProvider>();
  }

  Future<bool> login({required String phone, required String password}) async {
    final ApiResponse<Map<String, dynamic>> response = await _apiService.post(
      "/login",
      {'phone': phone, 'password': password},
      fromJsonT: (json) => json as Map<String, dynamic>,
    );

    if (response.success &&
        response.data != null &&
        response.data!['token'] != null) {
      logger.d(_tokenService.decodeToken(response.data!["token"]));
      _tokenService.setToken(response.data!['token']);
      _userAuthService.saveUser(response.data!["token"]);
      _userAuthService.setUserName(username: password);
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout({Function? callback, bool removeUser = false}) async {
    try {
      await _apiService.post('/logout', {}, fromJsonT: (json) => json);
      await _tokenService.clearToken();
      logger.i("User logged out successfully.");
      callback?.call();
      if (removeUser){
        _userAuthService.clearUser();
        _cache.clear();
      }
    } catch (e) {
      logger.e("Error during logout: $e");
    }
  }

  Future<bool> register({required Map<String, String> data}) async{
    final ApiResponse<Map<String, dynamic>> response = await _apiService.post(
      "/client/register", data,
      fromJsonT: (json) => json as Map<String, dynamic>,
    );

    if (response.success &&
        response.data != null &&
        response.data!['token'] != null) {
      logger.d(_tokenService.decodeToken(response.data!["token"]));
      _tokenService.setToken(response.data!['token']);
      _userAuthService.saveUser(response.data!["token"]);
      return true;
    } else {
      return false;
    }

  }

  Future<bool> loginOffline({required String password}) async {
    String? token =  await _userAuthService.loginOffline(password: password);
    if(token != null){
      _tokenService.setToken(token);
      logger.d(token);
      logger.d("Login successfully in offline: ${_tokenService.decodeToken(token)}");
      return true;
    }
    return false;
  }
}
