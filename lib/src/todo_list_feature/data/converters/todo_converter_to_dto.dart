import 'package:todo_testwork/core/architecture/data/converter/converter.dart';
import 'package:todo_testwork/src/todo_list_feature/data/data_source/database.dart';
import 'package:todo_testwork/src/todo_list_feature/domain/entity/todo_entity.dart';

final class TodoConverterFromEntity extends Converter<TodoItem, TodoEntity> {
  const TodoConverterFromEntity();

  @override
  TodoItem convert(TodoEntity input) {
    return TodoItem(
      id: input.id,
      title: input.title,
      isFinished: input.isCompleted,
      index: DateTime.fromMillisecondsSinceEpoch(input.index),
      color: input.color.color.value,
    );
  }
}
