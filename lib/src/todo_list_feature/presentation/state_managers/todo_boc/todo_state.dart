part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  TodoState({required this.hiddenLoading, this.selectedItem});
  final TodoEntity? selectedItem;
  final bool hiddenLoading;

  TodoState copyWith({bool? hiddenLoading, TodoEntity? selectedItem});
}

final class Loading extends TodoState {
  Loading() : super(hiddenLoading: false);

  @override
  List<Object?> get props => [];

  @override
  TodoState copyWith({bool? hiddenLoading, TodoEntity? selectedItem }) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}

final class Loaded extends TodoState {
  Loaded({required this.todoList, this.setHiddenLoading, this.selectedItem})
      : super(
            hiddenLoading: setHiddenLoading ?? false,
            selectedItem: selectedItem);
  final List<TodoEntity> todoList;

  final bool? setHiddenLoading;
  final TodoEntity? selectedItem;

  @override
  List<Object?> get props => [todoList, setHiddenLoading, selectedItem];

  @override
  TodoState copyWith({bool? hiddenLoading, TodoEntity? selectedItem}) {
    return Loaded(
      todoList: todoList,
      setHiddenLoading: hiddenLoading ?? setHiddenLoading,
      selectedItem: selectedItem ?? selectedItem,
    );
  }
}

final class Error extends TodoState {
  Error(this.message) : super(hiddenLoading: false);
  final String message;

  @override
  List<Object?> get props => [message];

  @override
  TodoState copyWith({bool? hiddenLoading, TodoEntity?  selectedItem}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}
