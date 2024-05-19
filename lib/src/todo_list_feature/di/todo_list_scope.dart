import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_testwork/src/app/di/app_scope.dart';
import 'package:todo_testwork/src/todo_list_feature/data/converters/todo_converter_from_dto.dart';
import 'package:todo_testwork/src/todo_list_feature/data/converters/todo_converter_to_dto.dart';
import 'package:todo_testwork/src/todo_list_feature/data/repository/todos_repository.dart';
import 'package:todo_testwork/src/todo_list_feature/presentation/state_managers/todo_boc/todo_bloc.dart';

class TodoListScope {
  final TodoBloc todoListBloc;

  TodoListScope(this.todoListBloc);
  factory TodoListScope.create(BuildContext context) {
    final appScope = context.read<AppScope>();
    final todoEntityToDtoConverter = TodoConverterFromEntity();
    final todoDtoToEntityConverter = TodoConverterFromDto();

    final TodosRepository todosRepository = TodosRepository(
      database: appScope.database,
      todoEntityToDtoConverter: todoEntityToDtoConverter,
      todoDtoToEntityConverter: todoDtoToEntityConverter,
    );
    final TodoBloc todoListBloc = TodoBloc(todosRepository)
      ..add(GetItemsEvent());

    return TodoListScope(todoListBloc);
  }
}
