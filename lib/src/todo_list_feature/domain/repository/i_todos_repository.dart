import 'package:todo_testwork/core/architecture/data/domain/request_operation.dart';
import 'package:todo_testwork/src/app/app_constants/item_colors.dart';
import 'package:todo_testwork/src/todo_list_feature/domain/entity/todo_entity.dart';
/// Interface of a repository for the TodoListFeature.
abstract interface class ITodosRepository {
  /// Returns a list of [TodoEntity] from the database.
  RequestOperation<List<TodoEntity>> getTodos();
  /// Delete the todo
  RequestOperation<bool> deleteTodo(int id);
  /// Create new todo
  RequestOperation<bool> addTodo(String title, ItemColors color);
  /// Marks the todo as a completed
  RequestOperation<bool> doneTodo(int id);
  /// Updates the todo
  RequestOperation<bool> updateTodo(int id, String title);
  /// Replace the todo to the another position
  RequestOperation<bool> swapTodos({required int firstTodoId, required int secondTodoId});
}
