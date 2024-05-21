import 'package:todo_testwork/core/architecture/data/converter/converter.dart';
import 'package:todo_testwork/src/todo_list_feature/data/data_source/database.dart';
import 'package:todo_testwork/src/todo_list_feature/domain/entity/todo_entity.dart';

final class TodoConverterFromDto extends Converter<TodoEntity, TodoItem> {
  const TodoConverterFromDto();

  @override
  TodoEntity convert(TodoItem input) {
    return TodoEntity(
      id: input.id,
      title: input.title,
      isCompleted: input.isFinished,
      index: input.index.millisecondsSinceEpoch,
    );
  }
}
