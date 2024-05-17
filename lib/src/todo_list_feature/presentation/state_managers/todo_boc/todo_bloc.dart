// ignore_for_file: library_private_types_in_public_api, constant_identifier_names

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_testwork/core/architecture/data/domain/result.dart';
import 'package:todo_testwork/src/todo_list_feature/domain/entity/todo_entity.dart';
import 'package:todo_testwork/src/todo_list_feature/domain/repository/i_todos_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  //late final Stream<List<TodoEntity>> _todoListStream;
  TodoBloc(this.todosRepository) : super(Loading()) {
    on<TodoEvent>((event, emitter) async {
      await switch (event) {
        GetItemsEvent() => getTodoList(event, emitter),
        AddEvent() => addTodo(event, emitter),
        DoneEvent() => doneTodo(event, emitter),
        DeleteEvent() => deleteTodo(event, emitter),
        LoadFromStreamEvent() => updateFromStream(event, emitter),
        ErrorFromStreamEvent() => errorFromStream(event, emitter),
      };
      // ignore: unused_label
      transformer:
      sequential();
    });
    // _todoListStream = todosRepository.getDbSrtream();

    // _todoListStream.listen((event) {
    //   switch (event) {
    //     case ResultOk():
    //       add(LoadFromStreamEvent(todoList: event.data));
    //     case ResultFailed():
    //       add(
    //         ErrorFromStreamEvent(
    //           errorMessage: event.failure.toString(),
    //         ),
    //       );
    //   }
    // });
  }
  final ITodosRepository todosRepository;

  TodoState get initialState => Loading();

  Future<void> updateFromStream(
      LoadFromStreamEvent event, Emitter<TodoState> emitter) async {
    emitter(
      Loaded(event.todoList),
    );
  }

  Future<void> errorFromStream(
      ErrorFromStreamEvent event, Emitter<TodoState> emitter) async {
    emitter(
      Error(event.errorMessage),
    );
  }

  Future<void> addTodo(AddEvent event, Emitter<TodoState> emitter) async {
    unawaited(todosRepository.addTodo(event.todo));
    if (state is Loaded) {
      emitter(
        Loaded(
          List.from((state as Loaded).todoList)
            ..add(
              event.todo,
            ),
        ),
      );
    }
  }

  Future<void> doneTodo(DoneEvent event, Emitter<TodoState> emitter) async {
    unawaited(todosRepository.updateTodo(event.id, event.finished));
    if (state is Loaded) {
      final todoList = List<TodoEntity>.from((state as Loaded).todoList);
      final index = todoList.indexWhere((element) => element.id == event.id);
      final newItem = todoList[index].copyWith(isCompleted: event.finished);
      todoList
        ..removeAt(index)
        ..insert(index, newItem);

      emitter(
        Loaded(
          todoList,
        ),
      );
    }
  }

  Future<void> deleteTodo(DeleteEvent event, Emitter<TodoState> emitter) async {
    unawaited(todosRepository.deleteTodo(event.todo.id));
    if (state is Loaded) {
      final todoList = List<TodoEntity>.from((state as Loaded).todoList);
      final result = todoList
        ..removeWhere((element) => element.id == event.todo.id);

      emitter(
        Loaded(
          result,
        ),
      );
    }
  }

  Future<void> getTodoList(TodoEvent event, Emitter<TodoState> emitter) async {
    emitter(
      Loading(),
    );

    final result = await todosRepository.getTodos();
    switch (result) {
      case ResultOk(:final data):
        emitter(Loaded(data));
      case ResultFailed():
        emitter(Error(SERVER_FAILURE_MESSAGE));
    }
  }
}
