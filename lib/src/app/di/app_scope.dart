import 'package:todo_testwork/src/app/logger.dart';
import 'package:todo_testwork/src/todo_list_feature/data/data_source/database.dart';

class AppScope {
  AppScope({required this.database, required this.logger});

  final AppDatabase database;
  final Logger logger;
  
}