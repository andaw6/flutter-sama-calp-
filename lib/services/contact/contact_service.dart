import 'package:logger/logger.dart';
import 'package:wave_odc/config/app_provider.dart';
import 'package:wave_odc/models/api_reponse.dart';
import 'package:wave_odc/models/contact/contact.dart';
import 'package:wave_odc/services/provider/interfaces/IApiService.dart';

class ContactService {
  final logger = Logger();
  final IApiService _apiService;

  ContactService()
      : _apiService = locator<IApiService>(param1: "/contacts");


        Future<List<Contact>> getContacts() async {
    final ApiResponse<Map<String, dynamic>> response = await _apiService
        .get("/current", fromJsonT: (json) => json as Map<String, dynamic>);
    if (response.success) {
      return response.dataList!.map((e) => Contact.fromJson(e)).toList();
    } else {
      throw Exception("Erreur lors de la récupération de l'utilisateur");
    }
  }
}
