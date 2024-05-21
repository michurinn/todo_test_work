part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  TodoState({required this.hiddenLoading, this.selectedItemId});
  final int? selectedItemId;
  final bool hiddenLoading;

  TodoState copyWith({bool? hiddenLoading, int? selectedItemId});
}

final class Loading extends TodoState {
  Loading() : super(hiddenLoading: false);

  @override
  List<Object?> get props => [];

  @override
  TodoState copyWith({bool? hiddenLoading, int? selectedItemId}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}

final class Loaded extends TodoState {
  Loaded({required this.todoList, this.setHiddenLoading, this.selectedItemId})
      : super(
            hiddenLoading: setHiddenLoading ?? false,
            selectedItemId: selectedItemId);
  final List<TodoEntity> todoList;

  final bool? setHiddenLoading;
  final int? selectedItemId;

  @override
  List<Object?> get props => [todoList, setHiddenLoading, selectedItemId];

  @override
  TodoState copyWith({bool? hiddenLoading, int? selectedItemId}) {
    return Loaded(
      todoList: todoList,
      setHiddenLoading: hiddenLoading ?? setHiddenLoading,
      selectedItemId: selectedItemId ?? selectedItemId,
    );
  }
}

final class Error extends TodoState {
  Error(this.message) : super(hiddenLoading: false);
  final String message;

  @override
  List<Object?> get props => [message];

  @override
  TodoState copyWith({bool? hiddenLoading, int? selectedItemId}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}
