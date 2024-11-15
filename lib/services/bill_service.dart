import 'package:logger/logger.dart';
import 'package:wave_odc/config/app_provider.dart';
import 'package:wave_odc/models/api_reponse.dart';
import 'package:wave_odc/models/bill/bill.dart';
import 'package:wave_odc/services/provider/interfaces/IApiService.dart';

class BillService {
  final logger = Logger();
  final IApiService _apiService;

  BillService()
      : _apiService = locator<IApiService>(param1: "/bills");


   Future<List<Bill>> getBills() async {
    final ApiResponse<Map<String, dynamic>> response = await _apiService
        .get("/current", fromJsonT: (json) => json as Map<String, dynamic>);
    if (response.success) {
      return response.dataList!.map((e) => Bill.fromJson(e)).toList();
    } else {
      throw Exception("Erreur lors de la récupération de l'utilisateur");
    }
  }
}
