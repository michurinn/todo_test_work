import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_testwork/src/app/di/app_scope.dart';
import 'package:todo_testwork/src/todo_list_feature/data/converters/todo_converter_from_dto.dart';
import 'package:todo_testwork/src/todo_list_feature/data/converters/todo_converter_to_dto.dart';
import 'package:todo_testwork/src/todo_list_feature/data/repository/todos_repository.dart';
import 'package:todo_testwork/src/todo_list_feature/presentation/state_managers/todo_boc/todo_bloc.dart';

/// Scope of the TodoListFeature
class TodoListScope {
  /// Scope of the TodoListFeature
  TodoListScope(this.todoListBloc);

  /// Create an instance of TodoListScope
  factory TodoListScope.create(BuildContext context) {
    final appScope = context.read<AppScope>();
    const todoEntityToDtoConverter = TodoConverterFromEntity();
    const todoDtoToEntityConverter = TodoConverterFromDto();

    final TodosRepository todosRepository = TodosRepository(
      database: appScope.database,
      todoEntityToDtoConverter: todoEntityToDtoConverter,
      todoDtoToEntityConverter: todoDtoToEntityConverter,
    );
    final TodoBloc todoListBloc = TodoBloc(todosRepository)
      ..add(GetItemsEvent());

    return TodoListScope(todoListBloc);
  }

  /// Bloc for the TodoListFeature
  final TodoBloc todoListBloc;
}
