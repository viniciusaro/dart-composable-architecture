import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

class NavigationDestination<T extends Disposable> extends StatelessWidget {
  final T? _value;
  final Widget child;
  final Widget Function(BuildContext, T) builder;

  const NavigationDestination(
    T? value, {
    super.key,
    required this.child,
    required this.builder,
  }) : _value = value;

  @override
  Widget build(BuildContext context) {
    final value = _value;
    return Navigator(
      pages: [
        MaterialPage(child: child),
        if (value != null) MaterialPage(child: builder(context, value)),
      ],
      onDidRemovePage: (page) {
        _value?.dispose();
      },
    );
  }
}

extension WidgetNavigation on Widget {
  NavigationDestination<T> navigationDestination<T extends Disposable>(
    T? value, {
    required Widget Function(BuildContext, T) builder,
  }) {
    return NavigationDestination(
      value,
      builder: builder,
      child: this,
    );
  }
}
