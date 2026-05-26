import 'package:dio/dio.dart';

class TodoApi {
  static const String _baseUrl =
      'https://ukwxueithfvflersufwb.supabase.co/rest/v1';
  static const String _anonKey =
      'sb_publishable_PVgs04zSrwwKTcvNol35HA_jf-5oIrb';
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'apikey': _anonKey,
        'Authorization': 'Bearer $_anonKey',
        'Content-Type': 'application/json',
        'Prefer': 'return=representation',
      },
    ),
  );

  // 1. FETCH (GET) - Lấy danh sách Todo sắp xếp theo id giảm dần
  Future<List<dynamic>> getTodos() async {
    try {
      final response = await _dio.get('/todos?select=*&order=id.desc');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // 2. ADD (POST) - Thêm một Todo mới
  Future<Map<String, dynamic>> addTodo(String title, String description) async {
    try {
      final response = await _dio.post(
        '/todos',
        data: {
          'title': title,
          'description': description,
          'is_completed': false,
        },
      );
      return (response.data as List).first;
    } catch (e) {
      rethrow;
    }
  }

  // 3. UPDATE (PATCH) - Cập nhật trạng thái Todo
  Future<void> toggleTodoStatus(int id, bool isCompleted) async {
    try {
      await _dio.patch('/todos?id=eq.$id', data: {'is_completed': isCompleted});
    } catch (e) {
      rethrow;
    }
  }
}
