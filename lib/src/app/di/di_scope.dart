import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo_testwork/src/app/di/app_scope.dart';

/// Di container. T - return type(for example [AppScope]).
class DIScope<T> extends StatelessWidget {
  /// Create an instance [DIScope].
  const DIScope({
    required this.scope,
    required this.child,
    super.key,
  });
  // ignore: public_member_api_docs
  final T scope;
  // ignore: public_member_api_docs
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => scope,
      child: child,
    );
  }
}
