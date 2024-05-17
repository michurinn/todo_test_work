part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {}

final class Empty extends TodoState {
  Empty();

  @override
  List<Object?> get props => [];
}

final class Loading extends TodoState {
  Loading();

  @override
  List<Object?> get props => [];
}

final class Loaded extends TodoState {
  final List<TodoEntity> todoList;

  Loaded(this.todoList);

  @override
  List<Object?> get props => [todoList];
}

final class Error extends TodoState {
  final String message;

  Error(this.message);

  @override
  List<Object?> get props => [];
}
