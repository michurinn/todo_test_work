import 'package:todo_testwork/core/architecture/data/domain/request_operation.dart';
import 'package:todo_testwork/src/todo_list_feature/domain/entity/todo_entity.dart';

abstract interface class ITodosRepository {
  RequestOperation<List<TodoEntity>> getTodos();
  RequestOperation<bool> deleteTodo(int id);
  RequestOperation<bool> addTodo(TodoEntity todo);
  RequestOperation<bool> updateTodo(int id, bool isFinished);

 // Stream<Result<List<TodoEntity>, Failure<Object?>>> getDbSrtream();
}
