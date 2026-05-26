import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/data/models/todo_model.dart';
import 'package:todo_app_bloc/data/repositories/todo_repository.dart';
import 'package:todo_app_bloc/logic/bloc/todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;

  // Constructor: Đặt State đầu tiên là Initial
  TodoBloc(this.todoRepository) : super(TodoInitialState()) {
    // Đăng ký xử lý khi có LoadTodoEvent
    on<LoadTodosEvent>((event, emit) async {
      emit(TodoLoadingState()); // Phát ra trạng thái loading ngay lập tức
      try {
        final todos = await todoRepository.fetchTodos();
        emit(
          TodoLoadedState(todos),
        ); // Thành công -> Phát ra LoadedState kèm data
      } catch (e) {
        emit(TodoErrorState(e.toString())); // Thất bại -> Phát ra ErrorState
      }
    });

    // Bên trong Constructor của TodoBloc, thêm handler cho ToggleTodoEvent:
    on<ToggleTodoEvent>((event, emit) async {
      try {
        // Gọi sang repo để update trên DB Cloud
        await todoRepository.updateCompletedStatus(event.id, event.isCompleted);

        // Mẹo thực tế: Sau khi update thành công, tự add thêm event LoadTodosEvent
        // để BLoC tự động fetch lại data mới nhất hiển thị lên màn hình
        add(LoadTodosEvent());
      } catch (e) {
        emit(TodoErrorState(e.toString()));
      }
    });

    on<AddTodoEvent>((event, emit) async {
      emit(TodoLoadingState());
      try {
        await todoRepository.addTodo(event.title, event.description);
        add(LoadTodosEvent());
      } catch (e) {
        emit(TodoErrorState(e.toString()));
      }
    });
  }
}
