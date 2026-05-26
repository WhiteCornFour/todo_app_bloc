import 'package:todo_app_bloc/data/dataproviders/todo_api.dart';

class TodoRepository {
  final TodoApi api = TodoApi();

  Future<List<dynamic>> fetchTodos() async {
    final rawTodos = await api.getTodo();
    return rawTodos;
  }
}
