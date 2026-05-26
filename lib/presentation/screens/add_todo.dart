import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/logic/bloc/todo_bloc.dart';
import 'package:todo_app_bloc/logic/bloc/todo_event.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  // Tạo controller để lấy dữ liệu từ TextField
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new Todo"),
        leading: const BackButton(),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _descController,
              maxLines: 3, // Cho phép nhập nhiều dòng
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50), // Nút dài full-width
              ),
              onPressed: () {
                final title = _titleController.text.trim();
                final desc = _descController.text.trim();

                if (title.isNotEmpty) {
                  // Bắn event AddTodoEvent sang BLoC
                  context.read<TodoBloc>().add(
                    AddTodoEvent(title: title, description: desc),
                  );
                  // Quay trở lại màn hình trước đó (TodoScreen)
                  Navigator.pop(context);
                } else {
                  // Thêm thông báo nếu để trống Title
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a title!')),
                  );
                }
              },
              child: const Text('Save Todo', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
