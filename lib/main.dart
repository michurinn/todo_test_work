import 'package:flutter/material.dart';
import 'package:todo_testwork/src/app/app.dart';
import 'package:todo_testwork/src/app/di/app_scope.dart';
import 'package:todo_testwork/src/app/di/app_scoper_register.dart';
import 'package:todo_testwork/src/app/di/di_scope.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const scopeRegister = AppScopeRegister();
  final AppScope appScope = await scopeRegister.createScope();

  runApp(
    DIScope<AppScope>(
      scope: appScope,
      child: const App(),
    ),
  );
}
