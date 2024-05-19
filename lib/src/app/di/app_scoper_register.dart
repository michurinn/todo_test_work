import 'package:flutter/foundation.dart';
import 'package:todo_testwork/src/app/di/app_scope.dart';
import 'package:todo_testwork/src/app/logger.dart';
import 'package:todo_testwork/src/todo_list_feature/data/data_source/database.dart';

final class AppScopeRegister {
  const AppScopeRegister();
  Future<AppScope> createScope() async {
    final AppDatabase database = AppDatabase();
    final Logger logger = Logger();
    FlutterError.onError = (details) {
      logger.log(
        '${details.exceptionAsString()}/n${details.stack}',
      );
    };

    return AppScope(
      database: database,
      logger: logger,
    );
  }
}
