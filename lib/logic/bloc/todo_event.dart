import 'package:equatable/equatable.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class LoadTodosEvent extends TodoEvent {}

class ToggleTodoEvent extends TodoEvent {
  final int id;
  final bool isCompleted;

  const ToggleTodoEvent({required this.id, required this.isCompleted});

  @override
  List<Object> get props => [id, isCompleted];
}

class AddTodoEvent extends TodoEvent {
  final String title;
  final String description;

  const AddTodoEvent({required this.title, required this.description});

  @override
  List<Object> get props => [title, description];
}
