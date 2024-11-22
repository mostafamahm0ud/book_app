import 'package:dio/dio.dart';

class ApiServices {
  final Dio _dio = Dio();
  final baseUrl = 'https://www.googleapis.com/books/v1/';
  Future<Map<String, dynamic>> get({required String endPoint}) async {
    final resbonse = await _dio.get('$baseUrl$endPoint');
    return resbonse.data;
  }
}
