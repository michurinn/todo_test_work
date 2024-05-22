import 'package:todo_testwork/src/app/logger.dart';
import 'package:todo_testwork/src/todo_list_feature/data/data_source/database.dart';
/// {@template app_scope.class}
/// Scope of dependencies which are needed through the whole app's life.
/// {@endtemplate}
class AppScope {
  /// {@macro app_scope.class}
  AppScope({required this.database, required this.logger});
  /// Database
  final AppDatabase database;
  /// Logger
  final Logger logger;
  
}