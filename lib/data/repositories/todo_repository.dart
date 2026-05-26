import 'package:todo_app_bloc/data/dataproviders/todo_api.dart';
import 'package:todo_app_bloc/data/models/todo_model.dart';

class TodoRepository {
  final TodoApi api = TodoApi();

  Future<List<TodoModel>> fetchTodos() async {
    final rawTodos = await api.getTodos();
    List<TodoModel> data = rawTodos.map((e) => TodoModel.fromJson(e)).toList();
    return data;
  }

  Future<void> updateCompletedStatus(int id, bool isCompleted) async {
    await api.toggleTodoStatus(id, isCompleted);
  }

  Future<void> addTodo(String title, String description) async {
    await api.addTodo(title, description);
  }
}
