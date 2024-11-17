import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class TokenService {
  final _secureStorage = const FlutterSecureStorage();

  static const _authTokenKey = 'auth_token';

  Future<String?> getToken() async {
    return await _secureStorage.read(key: _authTokenKey);
  }

  Future<bool> isTokenExpired() async {
    final token = await getToken();
    if (token == null) return true; // No token, so it's expired

    try {
      final payload = Jwt.parseJwt(token);
      final expiryDate = DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
      return DateTime.now().isAfter(expiryDate);
    } catch (e) {
      return true; // If the token is invalid or cannot be decoded, consider it expired
    }
  }

  Map<String, dynamic> decodeToken(String token) {
    try {
      final payload = Jwt.parseJwt(token);
      return payload;
    } catch (e) {
      throw Exception("Token decoding error: $e");
    }
  }

  Future<void> setToken(String token) async {
    await _secureStorage.write(key: _authTokenKey, value: token);
  }

  Future<void> clearToken() async {
    await _secureStorage.delete(key: _authTokenKey);
  }
}
