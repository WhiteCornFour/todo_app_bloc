import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/logic/bloc/todo_bloc.dart';
import 'package:todo_app_bloc/logic/bloc/todo_event.dart';
import 'data/repositories/todo_repository.dart';
import 'presentation/screens/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TodoRepository(),
      child: BlocProvider(
        // Khởi tạo Bloc và gọi ngay event đầu tiên để load data
        create: (context) =>
            TodoBloc(RepositoryProvider.of<TodoRepository>(context))
              ..add(LoadTodosEvent()),
        child: const MaterialApp(home: TodoScreen()),
      ),
    );
  }
}
