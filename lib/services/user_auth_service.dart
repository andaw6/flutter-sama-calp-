import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wave_odc/config/app_provider.dart';
import 'package:wave_odc/services/token_service.dart';

class UserAuthService {
  final _secureStorage = const FlutterSecureStorage();
  final _tokenService = locator<TokenService>();
  static const _authTokenKey = 'user_auth';

  
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

  Future<void> clearUser() async {
    await _secureStorage.delete(key: _authTokenKey);
  }
}
