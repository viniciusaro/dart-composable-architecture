import 'package:flutter/material.dart';

class DefaultTabBarView extends StatefulWidget {
  final int selectedIndex;
  final List<Widget> children;
  final Widget Function(BuildContext, Widget child) builder;

  const DefaultTabBarView({
    super.key,
    this.selectedIndex = 0,
    required this.children,
    required this.builder,
  });

  @override
  State<DefaultTabBarView> createState() => DefaultTabBarViewState();
}

class DefaultTabBarViewState extends State<DefaultTabBarView>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      vsync: this,
      length: widget.children.length, //
    );

    _controller.index = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(covariant DefaultTabBarView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _controller.index = widget.selectedIndex;
    }
  }

  @override
  Widget build(BuildContext _) {
    return Builder(
      builder: (context) {
        return widget.builder(
          context,
          TabBarView(
            controller: _controller,
            children: widget.children, //
          ),
        );
      },
    );
  }
}

final class DefaultTabBar extends StatelessWidget {
  final List<Widget> tabs;

  const DefaultTabBar({super.key, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: tabs,
      controller:
          context
              .findAncestorStateOfType<DefaultTabBarViewState>()!
              ._controller,
    );
  }
}
