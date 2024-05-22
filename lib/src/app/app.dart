import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_testwork/src/app/di/di_scope.dart';
import 'package:todo_testwork/src/todo_list_feature/di/todo_list_scope.dart';
import 'package:todo_testwork/src/todo_list_feature/presentation/pages/sample_item_list_view.dart';
/// {@template app.class}
/// Application.
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app.class}
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
      ],
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      initialRoute: SampleItemListView.routeName,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (context) {
            switch (routeSettings.name) {
              case SampleItemListView.routeName:
                return DIScope<TodoListScope>(
                    scope: TodoListScope.create(context),
                    child: const SampleItemListView());
              default:
                return const SampleItemListView();
            }
          },
        );
      },
    );
  }
}
