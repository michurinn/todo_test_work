import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_testwork/core/architecture/data/domain/failure.dart';
import 'package:todo_testwork/core/architecture/data/domain/result.dart';
import 'package:todo_testwork/src/todo_list_feature/domain/entity/todo_entity.dart';
import 'package:todo_testwork/src/todo_list_feature/domain/repository/i_todos_repository.dart';
import 'package:todo_testwork/src/todo_list_feature/presentation/state_managers/todo_boc/todo_bloc.dart';

class MockITodosRepository extends Mock implements ITodosRepository {}

void main() {
  late MockITodosRepository todosRepository;
  late TodoBloc todoBloc;
  List<TodoEntity> todoList = [
    const TodoEntity(id: 1, title: '1', isCompleted: false),
    const TodoEntity(id: 2, title: '22', isCompleted: true),
    const TodoEntity(id: 3, title: '333', isCompleted: false),
  ];
  setUp(() {
    todosRepository = MockITodosRepository();
    todoBloc = TodoBloc(todosRepository);
  });

  group('TodoBloc', () {
    test('initialState should be Loading', () {
      // assert
      expect(todoBloc.initialState, equals(Loading()));
    });

    test(
      'should emit [Loading, Loaded] when getting data success',
      () async {
        // arrange
        when(() => todosRepository.getTodos()).thenAnswer(
          (_) => Future.value(
            ResultOk(todoList),
          ),
        );
        when(() => todosRepository.getTodos()).thenAnswer(
          (_) => Future.value(
            ResultOk(todoList),
          ),
        );

        // assert later
        final expected = [
          Loading(),
          Loaded(todoList),
        ];
        unawaited(expectLater(todoBloc.stream, emitsInOrder(expected)));
        // act
        todoBloc.add(GetItemsEvent());
      },
    );

    test(
      'should emit [Loading, Error] when getting data fail',
      () async {
        // arrange
        when(() => todosRepository.getTodos()).thenAnswer(
          (_) => Future.value(
            const ResultFailed(
              Failure(original: 'error', trace: null),
            ),
          ),
        );
        // assert later
        final expected = [
          Loading(),
          Error(''),
        ];
        unawaited(expectLater(todoBloc.stream, emitsInOrder(expected)));
        // act
        todoBloc.add(GetItemsEvent());
      },
    );

    test(
      'should successfully add an object',
      () async {
        // arrange
        const newItem = TodoEntity(id: 4, title: '4444', isCompleted: false);
        final resultList = List<TodoEntity>.from(todoList)..add(newItem);
        when(() => todosRepository.getTodos()).thenAnswer(
          (_) => Future.value(
            ResultOk(todoList),
          ),
        );
        when(() => todosRepository.addTodo(newItem)).thenAnswer(
          (_) => Future.value(
            const ResultOk(true),
          ),
        );
        // assert later
        final List<TodoState> expected = [
          Loading(),
          Loaded(todoList),
          Loaded(resultList),
        ];
        unawaited(expectLater(todoBloc.stream, emitsInOrder(expected)));
        // act
        todoBloc
          ..add(
            GetItemsEvent(),
          )
          ..add(
            AddEvent(todo: newItem),
          );
      },
    );

    test(
      'should successfully update an object',
      () async {
        // arrange
        const newItem = TodoEntity(
          id: 3,
          title: '333',
          isCompleted: true,
        );
        List<TodoEntity> todoListUpdated = [
          const TodoEntity(id: 1, title: '1', isCompleted: false),
          const TodoEntity(id: 2, title: '22', isCompleted: true),
          const TodoEntity(id: 3, title: '333', isCompleted: true),
        ];
        when(() => todosRepository.getTodos()).thenAnswer(
          (_) => Future.value(
            ResultOk(todoList),
          ),
        );
        when(() => todosRepository.updateTodo(newItem.id, newItem.isCompleted))
            .thenAnswer(
          (_) => Future.value(
            const ResultOk(true),
          ),
        );
        // assert later
        final List<TodoState> expected = [
          Loading(),
          Loaded(todoList),
          Loaded(todoListUpdated),
        ];
        unawaited(expectLater(todoBloc.stream, emitsInOrder(expected)));
        // act
        todoBloc
          ..add(
            GetItemsEvent(),
          )
          ..add(
            DoneEvent(finished: true, id: newItem.id),
          );
      },
    );

    test(
      'should successfully delete an object',
      () async {
        // arrange
        const newItem = TodoEntity(
          id: 3,
          title: '333',
          isCompleted: true,
        );
        List<TodoEntity> todoListUpdated = [
          const TodoEntity(id: 1, title: '1', isCompleted: false),
          const TodoEntity(id: 2, title: '22', isCompleted: true),
        ];
        when(() => todosRepository.getTodos()).thenAnswer(
          (_) => Future.value(
            ResultOk(todoList),
          ),
        );
        when(() => todosRepository.deleteTodo(newItem.id)).thenAnswer(
          (_) => Future.value(
            const ResultOk(true),
          ),
        );
        // assert later
        final List<TodoState> expected = [
          Loading(),
          Loaded(todoList),
          Loaded(todoListUpdated),
        ];
        unawaited(expectLater(todoBloc.stream, emitsInOrder(expected)));
        // act
        todoBloc
          ..add(
            GetItemsEvent(),
          )
          ..add(
            DeleteEvent(todo: newItem),
          );
      },
    );
  });
}
