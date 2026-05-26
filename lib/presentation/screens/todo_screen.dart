import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/logic/bloc/todo_bloc.dart';
import 'package:todo_app_bloc/logic/bloc/todo_event.dart';


class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App với BLoC & Dio'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Cách trigger (gọi) một Event từ UI
              context.read<TodoBloc>().add(LoadTodosEvent());
            },
          )
        ],
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          // Xử lý vẽ UI dựa theo từng State cụ thể
          if (state is TodoLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } 
          
          if (state is TodoLoadedState) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final item = state.todos[index];
                return ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text(item['title'] ?? ''),
                  trailing: Icon(
                    item['completed'] == true ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: item['completed'] == true ? Colors.green : Colors.grey,
                  ),
                );
              },
            );
          } 
          
          if (state is TodoErrorState) {
            return Center(
              child: Text('Đã có lỗi xảy ra: ${state.errorMessage}'),
            );
          }
          
          return const Center(child: Text('Bấm nút để tải dữ liệu.'));
        },
      ),
    );
  }
}