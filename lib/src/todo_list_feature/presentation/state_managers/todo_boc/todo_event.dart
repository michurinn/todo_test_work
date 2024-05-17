part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();
}

final class GetItemsEvent extends TodoEvent {
  @override
  List<Object?> get props => [];
}

final class LoadFromStreamEvent extends TodoEvent {
  LoadFromStreamEvent({required this.todoList});

  final List<TodoEntity> todoList;
  @override
  List<Object?> get props => [todoList];
}

final class ErrorFromStreamEvent extends TodoEvent {
  ErrorFromStreamEvent({required this.errorMessage});

  final String errorMessage;
  @override
  List<Object?> get props => [errorMessage];
}

final class AddEvent extends TodoEvent {
  AddEvent({required this.todo});

  final TodoEntity todo;
  @override
  List<Object?> get props => [];
}

final class DoneEvent extends TodoEvent {
  DoneEvent({
    required this.finished,
    required this.id,
  });
  final int id;
  final bool finished;
  @override
  List<Object?> get props => [finished];
}

final class DeleteEvent extends TodoEvent {
  final TodoEntity todo;
  DeleteEvent({required this.todo});
  @override
  List<Object?> get props => [];
}
