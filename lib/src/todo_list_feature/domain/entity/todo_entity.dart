import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_testwork/src/app/app_constants/item_colors.dart';

part 'todo_entity.freezed.dart';
/// Entity for the TodoListFeature.
@freezed
class TodoEntity with _$TodoEntity {
  /// Entity for the TodoListFeature.
  const factory TodoEntity({
    required int id,
    required String title,
    required int index,
    @Default(ItemColors.green) ItemColors color,
    @Default(false) bool isCompleted,
  }) = _TodoEntity;
}
