part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();
}

final class GetItemsEvent extends TodoEvent {
  @override
  List<Object?> get props => [];
}

final class SwapEvent extends TodoEvent {
  SwapEvent({
    required this.firsItemId,
    required this.secondItemId,
  });

  final int firsItemId;
  final int secondItemId;
  @override
  List<Object?> get props => [firsItemId, secondItemId];
}

final class DeleteCheckedEvent extends TodoEvent {
  DeleteCheckedEvent();
  @override
  List<Object?> get props => [];
}

final class SelectItem extends TodoEvent {
  final int id;
  SelectItem({required this.id});
  @override
  List<Object?> get props => [id];
}

final class UpdateItemTitle extends TodoEvent {
  final int id;
  final String title;
  UpdateItemTitle({required this.id, required this.title});
  @override
  List<Object?> get props => [id, title];
}

final class AddEvent extends TodoEvent {
  AddEvent({required this.title});

  final String title;
  @override
  List<Object?> get props => [title];
}

final class DoneEvent extends TodoEvent {
  DoneEvent({
    required this.id,
  });
  final int id;
  @override
  List<Object?> get props => [id];
}

final class DeleteEvent extends TodoEvent {
  final int id;
  DeleteEvent({required this.id});
  @override
  List<Object?> get props => [id];
}
