import 'package:wave_odc/models/pagination.dart';

class ApiResponse<T> {
  final bool success;
  final String? message;
  final T? data;
  final List<T>? dataList;
  final Pagination? pagination;
  final String? error;

  ApiResponse({
    required this.success,
    this.message,
    this.data,
    this.dataList,
    this.pagination,
    this.error,
  });

  // Named constructor for error handling
  ApiResponse.error({this.message, this.error})
      : success = false,
        data = null,
        dataList = null,
        pagination = null;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    final dataJson = json['data'];
    final errorJson = json['error'];

    return ApiResponse<T>(
      success: json['status'] == 'SUCCESS',
      message: json['message'],
      data: (dataJson != null && dataJson is! List) ? fromJsonT(dataJson) : null,
      dataList: (dataJson != null && dataJson is List) ? dataJson.map((item) => fromJsonT(item)).toList() : null,
      pagination: json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null,
      error: errorJson, // Set the error value
    );
  }
}
