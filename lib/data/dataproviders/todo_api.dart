import 'package:dio/dio.dart';

class TodoApi {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://jsonplaceholder.typicode.com",
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );

  getTodo() async {
    try {
      final response = await _dio.get('/todos?_limit=10');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
