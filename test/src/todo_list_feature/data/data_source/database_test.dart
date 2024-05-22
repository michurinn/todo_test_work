import 'package:flutter_test/flutter_test.dart';
import 'package:todo_testwork/src/todo_list_feature/data/data_source/database.dart';
// the file defined above, you can test any drift database of course

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase();
  });

  test('swap todos', () async {
    // arrange
    final firstItem =
        TodoItem(id: 0, index: DateTime.now(), isFinished: false, title: '0');
    final secondItem = TodoItem(
        id: 1,
        index: DateTime.now()..add(Duration(days: 366)),
        isFinished: false,
        title: '11');
    // act
    final id = await database.addTodo(firstItem.title);
    final secondId = await database.addTodo(firstItem.title);
    final user = await database.swapItems(firstItem.id, secondItem.id);
    final swapped = await database.getTodo();
    // assert

    expect(swapped, [
      firstItem.copyWith(index: secondItem.index),
      secondItem.copyWith(index: firstItem.index)
    ]);
  });

  tearDown(() async {
    await database.close();
  });
}
