part of 'todo_bloc.dart';
/// Base class for the Events of the Todo bloc.
sealed class TodoEvent extends Equatable {
  const TodoEvent();
}
/// Get all todos
final class GetItemsEvent extends TodoEvent {
  @override
  List<Object?> get props => [];
}
/// {@template swap_event.class}
/// Put todo with [firsItemId] at the place of [secondItemId]
/// {@endtemplate}
final class SwapEvent extends TodoEvent {
  /// {@macro swap_event.class}
  const SwapEvent({
    required this.firsItemId,
    required this.secondItemId,
  });
/// {@macro swap_event.class}
  final int firsItemId;
  /// {@macro swap_event.class}
  final int secondItemId;
  @override
  List<Object?> get props => [firsItemId, secondItemId];
}
/// {@template swap_event.class}
/// Deletes the event is checked currently
/// {@endtemplate}
final class DeleteCheckedEvent extends TodoEvent {
   /// {@macro swap_event.class}
  const DeleteCheckedEvent();
  @override
  List<Object?> get props => [];
}
/// {@template swap_event.class}
/// Markes [todo] as selected
/// {@endtemplate}
final class SelectItem extends TodoEvent {
  /// {@macro swap_event.class}
  const SelectItem({required this.todo});
  /// {@macro swap_event.class}
  final TodoEntity todo;
  @override
  List<Object?> get props => [todo];
}

/// Represents an event to update the title of a todo item.
///
/// This event is used to update the title of a specific todo item identified by its [id].
/// The new title is provided in the [title] parameter.
class UpdateItemTitle extends TodoEvent {

  /// Creates a new [UpdateItemTitle] event with the specified [id] and [title].
  const UpdateItemTitle({required this.id, required this.title});
  /// The ID of the todo item to update.
  final int id;

  /// The new title for the todo item.
  final String title;

  @override
  List<Object?> get props => [id, title];
}

/// The [AddEvent] class is used to encapsulate the necessary information
/// to add a new todo item to the todo list. It contains the [title] of
/// the new todo item.

/// Represents an event to add a new todo item.
///
/// This event is used to notify the [TodoBloc] that a new todo item should be added.
/// The [title] property contains the title of the new todo item.
class AddEvent extends TodoEvent {
  const AddEvent({required this.title});

  /// The title of the new todo item.
  final String title;

  @override
  List<Object?> get props => [title];
}


/// Represents an event that marks a todo item as done.
///
/// This event is used to update the state of a todo item to indicate that it has been completed.
/// The [id] property specifies the unique identifier of the todo item that has been marked as done.
class DoneEvent extends TodoEvent {
  /// Creates a new [DoneEvent] instance.
  ///
  /// The [id] parameter is required and represents the unique identifier of the todo item that has been marked as done.
  const DoneEvent({
    required this.id,
  });

  /// The unique identifier of the todo item that has been marked as done.
  final int id;

  @override
  List<Object?> get props => [id];
}


/// Represents an event to delete a todo item from the todo list.
///
/// The [DeleteEvent] class is used to signal the deletion of a todo item
/// with the specified [id]. This event is typically handled by a [TodoBloc]
/// to update the state of the todo list accordingly.
class DeleteEvent extends TodoEvent {

  /// Creates a new [DeleteEvent] with the specified [id].
  const DeleteEvent({required this.id});
  /// The unique identifier of the todo item to be deleted.
  final int id;

  @override
  List<Object?> get props => [id];
}


