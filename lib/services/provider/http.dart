import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:wave_odc/config/app_provider.dart';
import 'package:wave_odc/models/api_reponse.dart';
import 'package:wave_odc/services/config_service.dart';
import 'package:wave_odc/services/token_service.dart';
import 'package:wave_odc/services/provider/interfaces/IApiService.dart';
import 'package:wave_odc/utils/api_url.dart';

class HttpApiService implements IApiService {
  final ConfigService config = locator<ConfigService>();
  final TokenService _tokenService = locator<TokenService>();
  final String baseUrl;
  final logger = Logger();

  HttpApiService(this.baseUrl);

  @override
  Future<Map<String, String>> getHeaders() async {
    final token = await _tokenService.getToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  @override
  String buildUrl(String endpoint, Map<String, String>? queryParams) {
    final apiUrl = '$apiURL$baseUrl$endpoint';
    logger.i("url: $apiUrl");
    if (queryParams != null && queryParams.isNotEmpty) {
      final queryString = Uri(queryParameters: queryParams).query;
      return '$apiUrl?$queryString';
    }
    return apiUrl;
  }

  @override
  Future<ApiResponse<T>> get<T>(String endpoint,
      {Map<String, String>? queryParams,
      required T Function(Object? json) fromJsonT}) async {
    final headers = await getHeaders();
    final url = buildUrl(endpoint, queryParams);
    final response = await http.get(Uri.parse(url), headers: headers);
    final res = _handleResponse(response, fromJsonT);
    return res;
  }

  @override
  Future<ApiResponse<T>> post<T>(String endpoint, Map<String, dynamic> data,
      {Map<String, String>? queryParams,
      required T Function(Object? json) fromJsonT}) async {
    final headers = await getHeaders();
    final url = buildUrl(endpoint, queryParams);
    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(data));
    return _handleResponse(response, fromJsonT);
  }

  @override
  Future<ApiResponse<T>> put<T>(String endpoint, Map<String, dynamic> data,
      {Map<String, String>? queryParams,
      required T Function(Object? json) fromJsonT}) async {
    final headers = await getHeaders();
    final url = buildUrl(endpoint, queryParams);
    final response = await http.put(Uri.parse(url),
        headers: headers, body: json.encode(data));
    return _handleResponse(response, fromJsonT);
  }

  @override
  Future<ApiResponse<T>> patch<T>(String endpoint, Map<String, dynamic> data,
      {Map<String, String>? queryParams,
      required T Function(Object? json) fromJsonT}) async {
    final headers = await getHeaders();
    final url = buildUrl(endpoint, queryParams);
    final response = await http.patch(Uri.parse(url),
        headers: headers, body: json.encode(data));
    return _handleResponse(response, fromJsonT);
  }

  @override
  Future<ApiResponse<T>> delete<T>(String endpoint,
      {Map<String, String>? queryParams,
      required T Function(Object? json) fromJsonT}) async {
    final headers = await getHeaders();
    final url = buildUrl(endpoint, queryParams);
    final response = await http.delete(Uri.parse(url), headers: headers);
    return _handleResponse(response, fromJsonT);
  }

  ApiResponse<T> _handleResponse<T>(
      http.Response? response, T Function(Object? json) fromJsonT) {
    if (response?.statusCode != null &&
        response!.statusCode >= 200 &&
        response.statusCode < 300) {
      final res = ApiResponse.fromJson(json.decode(response.body), fromJsonT);
      return res;
    } else {
      logger.e('Http Error ${response?.statusCode}: ${response!.reasonPhrase}');
      return ApiResponse<T>.error(
        message: 'Error ${response.statusCode}: ${response.reasonPhrase}',
      );
    }
  }
}
