
import 'package:equatable/equatable.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class LoadTodosEvent extends TodoEvent {}
