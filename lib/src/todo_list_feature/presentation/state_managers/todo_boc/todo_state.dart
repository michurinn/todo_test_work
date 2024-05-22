part of 'todo_bloc.dart';

/// Represents the state of the TodoList feature.
/// The `TodoState` class is the base class for all states in the TodoList feature.
sealed class TodoState extends Equatable {
  /// The `TodoState` class is the base class for all states in the TodoList feature.
  // ignore: prefer_const_constructors_in_immutables
  TodoState({required this.hiddenLoading, this.selectedItem});

  /// The `selectedItem` property represents the currently selected TodoEntity, and can be `null` if no item is selected.
  final TodoEntity? selectedItem;

  /// The `hiddenLoading` property indicates whether the loading state should be hidden or not.

  final bool hiddenLoading;

  /// The `TodoState` class also provides a `copyWith` method to create a new instance of the state with modified properties.
  TodoState copyWith({bool? hiddenLoading, TodoEntity? selectedItem});
}

/// Represents the loading state of the TodoState.
///
/// This state indicates that the TodoState is currently in a loading state.
/// The [hiddenLoading] property determines whether the loading state should be hidden or displayed.
final class Loading extends TodoState {
  Loading() : super(hiddenLoading: false);

  @override
  List<Object?> get props => [];

  @override
  TodoState copyWith({bool? hiddenLoading, TodoEntity? selectedItem}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}

/// Represents the state of a loaded TodoList, including the list of TodoEntity items,
/// an optional flag to indicate if the loading should be hidden, and an optional
/// selected TodoEntity item.
///
/// The [Loaded] state extends the [TodoState] class and provides a [copyWith] method
/// to create a new instance with updated properties.
final class Loaded extends TodoState {
  Loaded({required this.todoList, this.setHiddenLoading, super.selectedItem})
      : super(
            hiddenLoading: setHiddenLoading ?? false,
            );
  // ignore: public_member_api_docs
  final List<TodoEntity> todoList;

  /// /// The `hiddenLoading` property indicates whether the loading state should be hidden or not.
  final bool? setHiddenLoading;

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

/// Represents an error state in the TodoState.
///
/// This class is used to represent an error state in the TodoState, containing
/// a message that describes the error.
///
/// The [Error] class extends the [TodoState] class and overrides the [copyWith]
/// method to provide a way to create a new instance of the [Error] class with
/// modified properties.
///
/// The [props] getter returns a list containing the [message] property, which
/// is used for equality comparison and state management.
final class Error extends TodoState {
  Error(this.message) : super(hiddenLoading: false);
  final String message;

  @override
  List<Object?> get props => [message];

  @override
  TodoState copyWith({bool? hiddenLoading, TodoEntity? selectedItem}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}
