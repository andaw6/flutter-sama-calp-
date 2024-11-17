import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:wave_odc/config/app_provider.dart';
import 'package:wave_odc/models/api_reponse.dart';
import 'package:wave_odc/services/auth/token_service.dart';
import 'package:wave_odc/services/config_service.dart';
import 'package:wave_odc/services/provider/interfaces/IApiService.dart';
import 'package:wave_odc/utils/api_url.dart';

class DioApiService implements IApiService {
  final ConfigService config = locator<ConfigService>();
  final TokenService _tokenService = locator<TokenService>();
  final Dio _dio;
  final logger = Logger();

  DioApiService(String baseUrl)
      : _dio = Dio(BaseOptions(
          baseUrl: '$apiURL$baseUrl',
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));

  @override
  Future<Map<String, String>> getHeaders() async {
    final token = await _tokenService.getToken();
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
    return _dio.options.headers.cast<String, String>();
  }

  @override
  String buildUrl(String endpoint, Map<String, String>? queryParams) {
    final url = _dio.options.baseUrl + endpoint;
    if (queryParams != null && queryParams.isNotEmpty) {
      final queryString = Uri(queryParameters: queryParams).query;
      return '$url?$queryString';
    }
    return url;
  }

  @override
  Future<ApiResponse<T>> get<T>(String endpoint,
      {Map<String, String>? queryParams,
      required T Function(Object? json) fromJsonT}) async {
    final headers = await getHeaders();
    final response = await _dio.get(buildUrl(endpoint, queryParams),
        options: Options(headers: headers));
    return _handleResponse(response, fromJsonT);
  }

  @override
  Future<ApiResponse<T>> post<T>(String endpoint, Map<String, dynamic> data,
      {Map<String, String>? queryParams,
      required T Function(Object? json) fromJsonT}) async {
    final headers = await getHeaders();
    final response = await _dio.post(buildUrl(endpoint, queryParams),
        data: data, options: Options(headers: headers));
    return _handleResponse(response, fromJsonT);
  }

  @override
  Future<ApiResponse<T>> put<T>(String endpoint, Map<String, dynamic> data,
      {Map<String, String>? queryParams,
      required T Function(Object? json) fromJsonT}) async {
    final headers = await getHeaders();
    final response = await _dio.put(buildUrl(endpoint, queryParams),
        data: data, options: Options(headers: headers));
    return _handleResponse(response, fromJsonT);
  }

  @override
  Future<ApiResponse<T>> patch<T>(String endpoint, Map<String, dynamic> data,
      {Map<String, String>? queryParams,
      required T Function(Object? json) fromJsonT}) async {
    final headers = await getHeaders();
    final response = await _dio.patch(buildUrl(endpoint, queryParams),
        data: data, options: Options(headers: headers));
    return _handleResponse(response, fromJsonT);
  }

  @override
  Future<ApiResponse<T>> delete<T>(String endpoint,
      {Map<String, String>? queryParams,
      required T Function(Object? json) fromJsonT}) async {
    final headers = await getHeaders();
    final response = await _dio.delete(buildUrl(endpoint, queryParams),
        options: Options(headers: headers));
    return _handleResponse(response, fromJsonT);
  }


  ApiResponse<T> _handleResponse<T>(
      Response? response, T Function(Object? json) fromJsonT) {
    if (response?.statusCode != null &&
        response!.statusCode! >= 200 &&
        response.statusCode! < 300) {
      return ApiResponse.fromJson(response.data, fromJsonT);
    } else {
      logger.e('Dio Error ${response?.statusCode}: ${response?.statusMessage}');
      // Return an error ApiResponse or throw an exception
      return ApiResponse<T>.error(
        message: 'Error ${response?.statusCode}: ${response?.statusMessage}',
      );
    }
  }
}
