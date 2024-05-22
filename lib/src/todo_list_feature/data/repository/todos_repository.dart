import 'package:todo_testwork/core/architecture/data/domain/failure.dart';
import 'package:todo_testwork/core/architecture/data/domain/request_operation.dart';
import 'package:todo_testwork/core/architecture/data/domain/result.dart';
import 'package:todo_testwork/src/app/app_constants/item_colors.dart';
import 'package:todo_testwork/src/todo_list_feature/data/converters/todo_converter_from_dto.dart';
import 'package:todo_testwork/src/todo_list_feature/data/converters/todo_converter_to_dto.dart';
import 'package:todo_testwork/src/todo_list_feature/data/data_source/database.dart';
import 'package:todo_testwork/src/todo_list_feature/domain/entity/todo_entity.dart';
import 'package:todo_testwork/src/todo_list_feature/domain/repository/i_todos_repository.dart';

/// The repository for the operating with Todo's in the database.
class TodosRepository implements ITodosRepository {
  /// The repository for the operating with Todo's in the database.
  TodosRepository({
    required this.database,
    required this.todoEntityToDtoConverter,
    required this.todoDtoToEntityConverter,
  });

  /// No comment
  final AppDatabase database;

  /// Converter for converting a [TodoEntity] to a [TodoItem].
  final TodoConverterFromEntity todoEntityToDtoConverter;

  /// Converter for converting a [TodoItem] to a [TodoEntity].
  final TodoConverterFromDto todoDtoToEntityConverter;

  @override
  RequestOperation<bool> updateTodo(int id, String title) async {
    try {
      await database.updateTodo(id, title);
      return const Result.ok(true);
    } on Object catch (e, s) {
      return Result.failed(
        Failure(original: e, trace: s),
      );
    }
  }

  @override
  RequestOperation<bool> addTodo(String title, ItemColors color) async {
    try {
      await database.addTodo(title, color.color.value);
      return const Result.ok(true);
    } on Object catch (e, s) {
      return Result.failed(
        Failure(original: e, trace: s),
      );
    }
  }

  @override
  RequestOperation<bool> swapTodos(
      {required int firstTodoId, required int secondTodoId}) async {
    try {
      await database.swapItems(firstTodoId, secondTodoId);
      return const Result.ok(true);
    } on Object catch (e, s) {
      return Result.failed(
        Failure(original: e, trace: s),
      );
    }
  }

  @override
  RequestOperation<bool> deleteTodo(int id) async {
    try {
      await database.deleteTodo(id);
      return const Result.ok(true);
    } on Object catch (e, s) {
      return Result.failed(
        Failure(original: e, trace: s),
      );
    }
  }

  @override
  RequestOperation<List<TodoEntity>> getTodos() async {
    try {
      final result = await database.getTodo();
      final converted =
          todoDtoToEntityConverter.convertMultiple(result).toList();
      return Result.ok(converted);
    } on Object catch (e, s) {
      return Result.failed(
        Failure(original: e, trace: s),
      );
    }
  }

  @override
  RequestOperation<bool> doneTodo(
    int id,
  ) async {
    try {
      await database.completeTodo(
        id,
      );
      return const Result.ok(true);
    } on Object catch (e, s) {
      return Result.failed(
        Failure(original: e, trace: s),
      );
    }
  }
}
