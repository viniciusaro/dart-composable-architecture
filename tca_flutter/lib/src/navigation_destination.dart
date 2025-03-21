import 'package:composable_architecture/composable_architecture.dart';
import 'package:flutter/material.dart';

class NavigationDestination<T> extends StatelessWidget {
  final T? _value;
  final Widget Function(BuildContext, T) builder;
  final Widget child;

  const NavigationDestination(
    T? value, {
    super.key,
    required this.builder,
    required this.child,
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
        final value = _value;
        if (value is Disposable) {
          value.dispose();
        }
      },
    );
  }
}

extension WidgetNavigation on Widget {
  NavigationDestination<T> navigationDestination<T>(
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
