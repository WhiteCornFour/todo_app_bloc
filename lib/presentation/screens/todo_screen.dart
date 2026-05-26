import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/logic/bloc/todo_bloc.dart';
import 'package:todo_app_bloc/logic/bloc/todo_event.dart';
import 'package:todo_app_bloc/presentation/screens/add_todo.dart';

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
          ),
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
                  title: Text(item.title),
                  subtitle: Text(item.description ?? "Khong co ghi chu"),
                  trailing: IconButton(
                    onPressed: () {
                      context.read<TodoBloc>().add(
                        ToggleTodoEvent(
                          id: item.id!,
                          isCompleted: !item.isCompleted,
                        ),
                      );
                    },
                    icon: Icon(
                      item.isCompleted == true
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                    ),
                    isSelected: item.isCompleted == true ? true : false,
                    color: item.isCompleted == true
                        ? Colors.green
                        : Colors.grey,
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
      floatingActionButton: FloatingActionButton(
        child: Text('+', style: TextStyle(fontSize: 20)),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddTodo()),
        ),
      ),
    );
  }
}
