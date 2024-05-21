import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:path/path.dart' as p;
// ignore: depend_on_referenced_packages
import 'package:sqlite3/sqlite3.dart';
import 'package:todo_testwork/src/app/app_constants/app_constants.dart';

part 'database.g.dart';

class TodoItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get index => dateTime().withDefault(currentDateAndTime)();
  TextColumn get title =>
      text().withLength(min: 1, max: AppConstants.maxTitleLenght)();
  BoolColumn get isFinished => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [TodoItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> addTodo(TodoItem todo) async {
    return managers.todoItems.create(
      (o) => o(
        title: todo.title,
      ),
    );
  }

  Future<List<TodoItem>> getTodo() async {
    return managers.todoItems.orderBy((o) => o.index.asc()).get();
  }

  Future<int> updateTodo(int id, String title) async {
    await managers.todoItems.filter((o) => o.id(id)).getSingle();
    final result = managers.todoItems.filter((f) => f.id.equals(id)).update(
          (o) => o(
            title: Value(title),
          ),
        );
    return result;
  }

  Future<int> completeTodo(
    int id,
  ) async {
    final status = await managers.todoItems.filter((o) => o.id(id)).getSingle();
    final result = managers.todoItems.filter((f) => f.id.equals(id)).update(
          (o) => o(
            isFinished: Value(!status.isFinished),
          ),
        );
    return result;
  }

  Future<bool> swapItems(int firstItemId, int secoItremId) async {
    final first =
        await managers.todoItems.filter((o) => o.id(firstItemId)).getSingle();
    final second =
        await managers.todoItems.filter((o) => o.id(secoItremId)).getSingle();
    final updated = first.copyWith(
      index: second.index.add(
        Duration(milliseconds: 100),
      ),
    );
    final result = await managers.todoItems.replace(updated);
    return result;
  }

  Future<int> deleteTodo(int id) async {
    final result = await managers.todoItems.filter((f) => f.id(id)).delete();
    return result;
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    // Also work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // Make sqlite3 pick a more suitable location for temporary files - the
    // one from the system may be inaccessible due to sandboxing.
    final cachebase = (await getTemporaryDirectory()).path;
    // We can't access /tmp on Android, which sqlite3 would try by default.
    // Explicitly tell it about the correct temporary directory.
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
