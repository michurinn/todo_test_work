import 'dart:async';

import 'package:todo_testwork/core/architecture/data/converter/converter.dart';
import 'package:todo_testwork/core/architecture/data/domain/failure.dart';
import 'package:todo_testwork/core/architecture/data/domain/request_operation.dart';
import 'package:todo_testwork/core/architecture/data/domain/result.dart';
import 'package:todo_testwork/src/todo_list_feature/data/converters/todo_converter_from_dto.dart';
import 'package:todo_testwork/src/todo_list_feature/data/converters/todo_converter_to_dto.dart';
import 'package:todo_testwork/src/todo_list_feature/data/data_source/database.dart';
import 'package:todo_testwork/src/todo_list_feature/domain/entity/todo_entity.dart';
import 'package:todo_testwork/src/todo_list_feature/domain/repository/i_todos_repository.dart';

class TodosRepository implements ITodosRepository {
  TodosRepository({
    required this.database,
    required this.todoEntityToDtoConverter,
    required this.todoDtoToEntityConverter,
  });

  final AppDatabase database;
  final TodoConverterFromEntity todoEntityToDtoConverter;
  final TodoConverterFromDto todoDtoToEntityConverter;

  @override
  RequestOperation<bool> addTodo(TodoEntity todo) async {
    final Completer<Result<bool, Failure<Object?>>> completer = Completer();
    try {
      await database.addTodo(todoEntityToDtoConverter.convert(todo));
      completer.complete(
        const Result.ok(true),
      );
    } on Object catch (e, s) {
      completer.complete(
        Result.failed(
          Failure(original: e, trace: s),
        ),
      );
    }
    return completer.future;
  }

  @override
  RequestOperation<bool> deleteTodo(int id) async {
    final Completer<Result<bool, Failure<Object?>>> completer = Completer();
    try {
      await database.deleteTodo(id);
      completer.complete(
        const Result.ok(true),
      );
    } on Object catch (e, s) {
      completer.complete(
        Result.failed(
          Failure(original: e, trace: s),
        ),
      );
    }
    return completer.future;
  }

  @override
  RequestOperation<List<TodoEntity>> getTodos() async {
    final Completer<Result<List<TodoEntity>, Failure<Object?>>> completer =
        Completer();
    try {
      final result = await database.getTodo();
      final converted =
          todoDtoToEntityConverter.convertMultiple(result).toList();
      completer.complete(Result.ok(converted));
    } on Object catch (e, s) {
      completer.complete(
        Result.failed(
          Failure(original: e, trace: s),
        ),
      );
    }
    return completer.future;
  }

  @override
  RequestOperation<bool> updateTodo(int id, bool isFinished) async {
    final Completer<Result<bool, Failure<Object?>>> completer = Completer();
    try {
      await database.updateTodo(id, isFinished);
      completer.complete(const Result.ok(true));
    } on Object catch (e, s) {
      completer.complete(
        Result.failed(
          Failure(original: e, trace: s),
        ),
      );
    }
    return completer.future;
  }
}
