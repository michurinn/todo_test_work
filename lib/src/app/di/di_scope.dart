import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class DIScope<T> extends StatelessWidget {
  const DIScope({
    super.key,
    required this.scope,
    required this.child,
  });
  final T scope;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => scope,
      child: child,
    );
  }
}
