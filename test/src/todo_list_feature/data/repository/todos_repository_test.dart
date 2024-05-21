// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_testwork/core/architecture/data/domain/result.dart';
import 'package:todo_testwork/src/todo_list_feature/data/converters/todo_converter_from_dto.dart';
import 'package:todo_testwork/src/todo_list_feature/data/converters/todo_converter_to_dto.dart';
import 'package:todo_testwork/src/todo_list_feature/data/data_source/database.dart';
import 'package:todo_testwork/src/todo_list_feature/data/repository/todos_repository.dart';
import 'package:todo_testwork/src/todo_list_feature/domain/entity/todo_entity.dart';

class MockTodoDatabase extends Mock implements AppDatabase {}

void main() {
  late TodosRepository repository;
  late TodoConverterFromDto converterDto;
  late TodoConverterFromEntity converterEntity;
  late AppDatabase db;
  setUp(() {
    registerFallbackValue(
      TodoItem(
        id: 1,
        isFinished: false,
        title: '',
        index: DateTime.now(),
      ),
    );
    converterDto = TodoConverterFromDto();
    converterEntity = TodoConverterFromEntity();
    db = MockTodoDatabase();
    repository = TodosRepository(
      todoEntityToDtoConverter: converterEntity,
      todoDtoToEntityConverter: converterDto,
      database: db,
    );
  });

  test('getTodos should return todos from data source', () async {
    // Arrange
    final todosDTO = [
      TodoItem(
        id: 1,
        title: 'Todo 1',
        isFinished: false,
        index: DateTime.now(),
      ),
      TodoItem(
        id: 2,
        title: 'Todo 2',
        isFinished: true,
        index: DateTime.now(),
      ),
    ];
    final todoEntities = [
      TodoEntity(id: 1, title: 'Todo 1', index: 1),
      TodoEntity(id: 2, title: 'Todo 2', isCompleted: true, index: 1),
    ];
    when(() => db.getTodo()).thenAnswer((_) async => Future.value(todosDTO));

    // Act
    final result = await repository.getTodos();

    // Assert
    expect((result as ResultOk).data, equals(todoEntities));
    verify(() => db.getTodo()).called(1);
  });

  test('addTodo should add todo to data source', () async {
    // Arrange
    final todo = TodoEntity(id: 1, title: 'New Todo', index: 1);

    when(() => db.addTodo(any<TodoItem>()))
        .thenAnswer((_) async => Future.value(1));

    // Act
    final result = await repository.addTodo(todo);

    // Assert
    expect((result as ResultOk).data, equals(true));
    verify(() => db.addTodo(any<TodoItem>())).called(1);
  });

  test('updateDoto should add todo to data source', () async {
    // Arrange
    final todo = TodoEntity(id: 1, title: 'New Todo', index: 1);

    when(() => db.completeTodo(todo.id,))
        .thenAnswer((_) async => Future.value(1));

    // Act
    final result = await repository.doneTodo(todo.id, );

    // Assert
    expect((result as ResultOk).data, equals(true));
    verify(() => db.completeTodo(todo.id, )).called(1);
  });

  test('delete should add todo to data source', () async {
    // Arrange
    final todo = TodoEntity(id: 1, title: 'New Todo', index: 1);

    when(() => db.deleteTodo(todo.id)).thenAnswer((_) async => Future.value(1));

    // Act
    final result = await repository.deleteTodo(todo.id);

    // Assert
    expect((result as ResultOk).data, equals(true));
    verify(() => db.deleteTodo(todo.id)).called(1);
  });
}
