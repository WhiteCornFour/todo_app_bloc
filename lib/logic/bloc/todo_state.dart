part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

// 1. Trạng thái khởi tạo
class TodoInitialState extends TodoState {}

// 2. Trạng thái đang loading API
class TodoLoadingState extends TodoState {}

// 3. Trạng thái đã tải xong và có dữ liệu
class TodoLoadedState extends TodoState {
  final List<dynamic> todos;
  const TodoLoadedState(this.todos);

  @override
  List<Object> get props => [todos];
}

// 4. Trạng thái lỗi
class TodoErrorState extends TodoState {
  final String errorMessage;
  const TodoErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
