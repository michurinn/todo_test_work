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
    const TodoEntity(
      id: 1,
      title: '1',
      index: 0,
    ),
    const TodoEntity(
      id: 2,
      title: '22',
      isCompleted: true,
      index: 1,
    ),
    const TodoEntity(
      id: 3,
      title: '333',
      index: 2,
    ),
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

        // assert later
        final expected = [
          Loaded(todoList: todoList),
        ];
        unawaited(
          expectLater(
            todoBloc.stream,
            emitsInOrder(expected),
          ),
        );
        // act
        todoBloc.add(
          GetItemsEvent(),
        );
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
          Error(''),
        ];
        unawaited(
          expectLater(
            todoBloc.stream,
            emitsInOrder(expected),
          ),
        );
        // act
        todoBloc.add(
          GetItemsEvent(),
        );
      },
    );

    test(
      'should successfully add an object',
      () async {
        // arrange
        const newItem = TodoEntity(id: 4, title: '4444', index: 1);
        final resultList = List<TodoEntity>.from(todoList)..add(newItem);
        when(() => todosRepository.getTodos()).thenAnswer(
          (_) => Future.value(
            ResultOk(todoList),
          ),
        );
        when(() => todosRepository.addTodo(newItem.title)).thenAnswer(
          (_) => Future.value(
            const ResultOk(true),
          ),
        );
        // assert later
        final List<TodoState> expected = [
          Loaded(todoList: todoList),
          Loaded(todoList: resultList),
        ];
        unawaited(
          expectLater(
            todoBloc.stream,
            emitsInOrder(expected),
          ),
        );
        // act
        todoBloc
          ..add(
            GetItemsEvent(),
          )
          ..add(
            AddEvent(title: newItem.title),
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
          index: 1,
          isCompleted: true,
        );
        List<TodoEntity> todoListUpdated = [
          const TodoEntity(
            id: 1,
            title: '1',
            index: 1,
          ),
          const TodoEntity(
            id: 2,
            title: '22',
            isCompleted: true,
            index: 1,
          ),
          const TodoEntity(
            id: 3,
            title: '333',
            isCompleted: true,
            index: 1,
          ),
        ];
        when(() => todosRepository.getTodos()).thenAnswer(
          (_) => Future.value(
            ResultOk(todoList),
          ),
        );
        when(() => todosRepository.doneTodo(newItem.id,))
            .thenAnswer(
          (_) => Future.value(
            const ResultOk(true),
          ),
        );
        // assert later
        final List<TodoState> expected = [
          Loaded(todoList: todoList),
          Loaded(todoList: todoListUpdated),
        ];
        unawaited(expectLater(todoBloc.stream, emitsInOrder(expected)));
        // act
        todoBloc.add(
          DoneEvent(id: newItem.id),
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
          index: 1,
        );
        List<TodoEntity> todoListUpdated = [
          const TodoEntity(
            id: 1,
            title: '1',
            index: 0,
          ),
          const TodoEntity(
            id: 2,
            title: '22',
            isCompleted: true,
            index: 1,
          ),
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
          Loaded(todoList: todoListUpdated),
        ];
        unawaited(expectLater(todoBloc.stream, emitsInOrder(expected)));
        // act
        todoBloc.add(
          DeleteEvent(id: newItem.id),
        );
      },
    );
  });
}
