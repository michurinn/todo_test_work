import 'package:todo_testwork/core/architecture/data/domain/request_operation.dart';
import 'package:todo_testwork/src/todo_list_feature/domain/entity/todo_entity.dart';

abstract interface class ITodosRepository {
  RequestOperation<List<TodoEntity>> getTodos();
  RequestOperation<bool> deleteTodo(int id);
  RequestOperation<bool> addTodo(String title);
  RequestOperation<bool> doneTodo(int id);
  RequestOperation<bool> updateTodo(int id, String title);
  RequestOperation<bool> swapTodos({required int firstTodoId, required int secondTodoId});
}
