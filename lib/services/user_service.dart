import 'package:logger/logger.dart';
import 'package:wave_odc/config/app_provider.dart';
import 'package:wave_odc/models/api_reponse.dart';
import 'package:wave_odc/models/users/user.dart';
import 'package:wave_odc/models/users/user_info.dart';
import 'package:wave_odc/services/provider/interfaces/IApiService.dart';

class UserService {
  final logger = Logger();
  final IApiService _apiService;

  UserService() : _apiService = locator<IApiService>(param1: "/users");

  Future<User> current() async {
    final ApiResponse<Map<String, dynamic>> response = await _apiService.get(
      "/current",
      fromJsonT: (json) => json as Map<String, dynamic>,
    );

    if (response.success) {
      return User.fromJson(response.data!);
    } else {
      throw Exception("Erreur lors de la récupération de l'utilisateur");
    }
  }

  Future<UserInfo?> findByPhone({required String phone}) async {
    final ApiResponse<Map<String, dynamic>> response = await _apiService.get(
      "/phone/$phone",
      fromJsonT: (json) => json as Map<String, dynamic>,
    );

    if (response.success) {
      return UserInfo.fromJson(response.data!);
    }
    {
      logger.e("Utilisateur avec le numéro $phone n'exist pas");
      return null;
    }
  }
}
