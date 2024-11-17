import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:wave_odc/utils/api_key.dart';


class JwtService {
  static const String _secretKey = apiKey;

  static String generateToken(Map<String, dynamic> payload, {Duration? expiresIn}) {
    final jwt = JWT(
      payload,
      // issuer: 'sama_calpé',
      subject: payload["phoneNumber"]??'sam_calpé',
      jwtId: DateTime.now().millisecondsSinceEpoch.toString(),
    );

    if (expiresIn != null) {
      payload['exp'] = DateTime.now().add(expiresIn).millisecondsSinceEpoch ~/ 1000;
    }
    final token = jwt.sign(SecretKey(_secretKey));
    return token;
  }

  static Map<String, dynamic> verifyToken(String token) {
    try {
      final jwt = JWT.verify(token, SecretKey(_secretKey));
      return jwt.payload;
    } on JWTException catch (e) {
      throw JWTException('Invalid token: ${e.message}');
    }
  }
}