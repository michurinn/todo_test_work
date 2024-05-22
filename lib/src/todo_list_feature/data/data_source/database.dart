// ignore_for_file: avoid_print

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:todo_testwork/src/app/app_constants/app_constants.dart';

part 'database.g.dart';

/// Table of TodoItem
class TodoItems extends Table {
  /// Unique id
  IntColumn get id => integer().autoIncrement()();

  /// Index in the list: by default item recently created has bigger index
  DateTimeColumn get index => dateTime().withDefault(currentDateAndTime)();

  /// Title of the item
  TextColumn get title =>
      text().withLength(min: 1, max: AppConstants.maxTitleLenght)();

  /// Color of the item
  IntColumn get color => integer().withDefault(const Constant(0xFFAABBCC))();

  /// Is item completed
  BoolColumn get isFinished => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [TodoItems])

/// App's database
class AppDatabase extends _$AppDatabase {
  /// App's database
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// CRUD - C
  Future<int> addTodo(String title, int color) async {
    final result = await managers.todoItems.createReturning(
      (o) => o(
        title: title,
        color: Value<int>(color),
      ),
    );
    return result.id;
  }

  /// CRUD - R
  Future<List<TodoItem>> getTodo() async {
    return managers.todoItems.orderBy((o) => o.index.asc()).get();
  }

  /// CRUD - U
  Future<int> updateTodo(int id, String title) async {
    await managers.todoItems.filter((o) => o.id(id)).getSingle();
    final result = managers.todoItems.filter((f) => f.id.equals(id)).update(
          (o) => o(
            title: Value(title),
          ),
        );
    return result;
  }

  /// CRUD - U
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

  /// CRUD - U
  Future<bool> swapItems(int firstItemId, int secoItremId) async {
    //TODO(me): replace this logic in SQL
    final first =
        await managers.todoItems.filter((o) => o.id(firstItemId)).getSingle();
    final second =
        await managers.todoItems.filter((o) => o.id(secoItremId)).getSingle();
    if (first.index.isAfter(second.index)) {
      //Moving down
      final downgradedSubree = await managers.todoItems
          .filter((o) => o.index.isAfterOrOn(second.index))
          .orderBy((o) => o.index.asc())
          .get()
        ..remove(first);
      for (final item in downgradedSubree) {
        await managers.todoItems.filter((o) => o.id(item.id)).update(
              (o) => o(
                index: Value(
                  second.index.add(
                    Duration(
                      seconds: 1 + downgradedSubree.indexOf(item),
                    ),
                  ),
                ),
              ),
            );
      }
    } else {
      //Moving up
      final upgradedSubree = await managers.todoItems
          .filter((o) => o.index.isBeforeOrOn(second.index))
          .orderBy((o) => o.index.desc())
          .get()
        ..remove(first);
      for (final item in upgradedSubree) {
        final addict = upgradedSubree.indexOf(item);
        final addictValue = second.index.subtract(
          Duration(
            seconds: 1 + addict,
          ),
        );
        await managers.todoItems.filter((o) => o.id(item.id)).update(
              (o) => o(
                index: Value(addictValue),
              ),
            );
      }
    }
    await managers.todoItems.filter((o) => o.id(firstItemId)).update(
          (o) => o(
            index: Value(second.index),
          ),
        );

    return true;
  }

  /// CRUD - D
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
