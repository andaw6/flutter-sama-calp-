import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wave_odc/config/app_provider.dart';
import 'package:wave_odc/services/auth/jwt_service.dart';
import 'package:wave_odc/services/auth/token_service.dart';

class UserAuthService {
  final _secureStorage = const FlutterSecureStorage();
  final _tokenService = locator<TokenService>();
  static const _authTokenKey = 'user_auth';
  static const _authPassword = "auth_username_password_connexion";
  
 Future<String?> getPhoneNumberUser() async {
    final dynamic info = await getUserInfo();
    return info != null && info.containsKey("phoneNumber")
        ? info["phoneNumber"]
        : null;
  }

  Future<String?> getUserRole() async {
    final dynamic info = await getUserInfo();
    return info != null && info.containsKey("role") ? info["role"] : null;
  }

  Future<void> saveUser(dynamic userInfo) async {
    await _secureStorage.write(key: _authTokenKey, value: userInfo);
  }

  Future<Map<String, dynamic>?> getUserInfo() async {
    final userInfoString = await _secureStorage.read(key: _authTokenKey);
    if (userInfoString != null) {
      return _tokenService.decodeToken(userInfoString);
    } else {
      return null; 
    }
  }

  void setUserName({required String username}) async{
   await _secureStorage.write(key: _authPassword, value: username);
  }

  Future<String?> loginOffline({required String password}) async {
    try {
      Map<String, dynamic>? userInfo = await getUserInfo();
      if(userInfo != null){
        if(password == await _secureStorage.read(key: _authPassword)){
          String token = JwtService.generateToken({
            "phoneNumber": userInfo["phoneNumber"],
            "role": userInfo["role"],
            "userId": userInfo["userId"]
          });
          return token;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> clearUser() async {
    await _secureStorage.delete(key: _authTokenKey);
    await _secureStorage.delete(key: _authPassword);
  }

}
