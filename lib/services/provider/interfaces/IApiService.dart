import 'package:wave_odc/models/api_reponse.dart' show ApiResponse;

abstract class IApiService {
  Future<Map<String, String>> getHeaders();

  String buildUrl(String endpoint, Map<String, String>? queryParams);
  
  Future<ApiResponse<T>> get<T>(
    String endpoint,
    {
      Map<String, String>? queryParams,
      required T Function(Object? json) fromJsonT
    }
  );

  Future<ApiResponse<T>> post<T>(
    String endpoint, 
    Map<String, dynamic> data,
    {
      Map<String, String>? queryParams,
      required T Function(Object? json) fromJsonT
    }
  );
  
  Future<ApiResponse<T>> put<T>(
    String endpoint, 
    Map<String, dynamic> data,
    {
      Map<String, String>? queryParams,
      required T Function(Object? json) fromJsonT
    }
  );

  Future<ApiResponse<T>> patch<T>(
    String endpoint, 
    Map<String, dynamic> data,
    {
      Map<String, String>? queryParams,
      required T Function(Object? json) fromJsonT
    }
  );

  Future<ApiResponse<T>> delete<T>(
    String endpoint,
    {
      Map<String, String>? queryParams,
      required T Function(Object? json) fromJsonT
    }
  );
}
