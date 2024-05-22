import 'package:todo_testwork/core/architecture/data/converter/converter.dart';
import 'package:todo_testwork/src/app/app_constants/item_colors.dart';
import 'package:todo_testwork/src/todo_list_feature/data/data_source/database.dart';
import 'package:todo_testwork/src/todo_list_feature/domain/entity/todo_entity.dart';
/// Converter for converting [TodoItem] to [TodoEntity]. 
final class TodoConverterFromDto extends Converter<TodoEntity, TodoItem> {
  /// Converter for converting [TodoItem] to [TodoEntity]. 
  const TodoConverterFromDto();

  @override
  TodoEntity convert(TodoItem input) {
    return TodoEntity(
      id: input.id,
      title: input.title,
      isCompleted: input.isFinished,
      index: input.index.millisecondsSinceEpoch,
      color: ItemColors.getColorByHex(input.color),
    );
  }
}
