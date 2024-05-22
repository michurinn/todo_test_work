// ignore_for_file: library_private_types_in_public_api, constant_identifier_names

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_testwork/core/architecture/data/domain/request_operation.dart';
import 'package:todo_testwork/core/architecture/data/domain/result.dart';
import 'package:todo_testwork/src/todo_list_feature/domain/entity/todo_entity.dart';
import 'package:todo_testwork/src/todo_list_feature/domain/repository/i_todos_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

const String QUERY_FAILURE_MESSAGE = 'Query Failure';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc(this.todosRepository)
      : super(
          Loading(),
        ) {
    on<TodoEvent>((event, emitter) async {
      await switch (event) {
        GetItemsEvent() => getTodoList(event, emitter),
        AddEvent() => addTodo(event, emitter),
        DoneEvent() => doneTodo(event, emitter),
        DeleteEvent() => deleteTodo(event, emitter),
        SwapEvent() => swapTodos(event, emitter),
        SelectItem() => selectItem(event, emitter),
        DeleteCheckedEvent() => deleteCheckedItem(event, emitter),
        UpdateItemTitle() => updateItemTitle(event, emitter),
      };
      // ignore: unused_label
      transformer:
      sequential();
    });
  }
  final ITodosRepository todosRepository;

  TodoState get initialState => Loading();

  Future<void> updateItemTitle(
      UpdateItemTitle event, Emitter<TodoState> emitter) async {
    await performWithUpdate(todosRepository.updateTodo(event.id, event.title));
  }

  Future<void> deleteCheckedItem(
      DeleteCheckedEvent event, Emitter<TodoState> emitter) async {
    final checkedId = state.selectedItem?.id;
    if (checkedId != null) {
      add(DeleteEvent(id: checkedId));
    }
  }

  Future<void> selectItem(SelectItem event, Emitter<TodoState> emitter) async {
    final uncheck = state.selectedItem?.id == event.todo.id;
    emitter(
      state.copyWith(
        hiddenLoading: state.hiddenLoading,
        selectedItem: uncheck ? null : event.todo,
      ),
    );
  }

  Future<void> swapTodos(SwapEvent event, Emitter<TodoState> emitter) async {
    await performWithUpdate(todosRepository.swapTodos(
      firstTodoId: event.firsItemId,
      secondTodoId: event.secondItemId,
    ));
  }

  Future<void> addTodo(AddEvent event, Emitter<TodoState> emitter) async {
    
    await performWithUpdate(todosRepository.addTodo(event.title));
  }

  Future<void> doneTodo(DoneEvent event, Emitter<TodoState> emitter) async {
    await todosRepository.doneTodo(
      event.id,
    );

    add(
      GetItemsEvent(),
    );
  }

  Future<void> deleteTodo(DeleteEvent event, Emitter<TodoState> emitter) async {
    await performWithUpdate(todosRepository.deleteTodo(event.id));
  }

  Future<void> getTodoList(TodoEvent event, Emitter<TodoState> emitter) async {
    if (state is Loaded) {
      emitter(
        Loaded(todoList: (state as Loaded).todoList, setHiddenLoading: true),
      );
    }
    final result = await todosRepository.getTodos();
    switch (result) {
      case ResultOk(:final data):
        final reversed = data.reversed.toList();
        emitter(
          Loaded(todoList: reversed),
        );
      case ResultFailed():
        emitter(
          Error(QUERY_FAILURE_MESSAGE),
        );
    }
  }

  Future<void> performWithUpdate(RequestOperation<bool> future) async {
    await future;
    add(
      GetItemsEvent(),
    );
  }
}
