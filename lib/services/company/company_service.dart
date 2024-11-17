import 'package:logger/logger.dart';
import 'package:wave_odc/config/app_provider.dart';
import 'package:wave_odc/models/api_reponse.dart';
import 'package:wave_odc/models/company/company.dart';
import 'package:wave_odc/services/provider/interfaces/IApiService.dart';

class CompanyService {
  final logger = Logger();
  final IApiService _apiService;

  CompanyService() : _apiService = locator<IApiService>(param1: "/companies");

  Future<List<Company>> getCompanies() async {
    final ApiResponse<Map<String, dynamic>> response = await _apiService
          .get("/all", fromJsonT: (json) => json as Map<String, dynamic>);
    if (response.success) {
      return response.dataList!.map((e) => Company.fromJson(e)).toList();
    } else {
      throw Exception("Erreur lors de la récupération de l'utilisateur");
    }
  }
}
