import 'package:composable_architecture/composable_architecture.dart';
import 'package:flutter/material.dart';

class WithViewStore<S, A> extends StatefulWidget {
  final Store<S, A> store;
  final Widget Function(Store<S, A> store) body;
  final void Function(Store<S, A> store)? onInitState;

  const WithViewStore(this.store, {super.key, this.onInitState, required this.body});

  @override
  State<WithViewStore<S, A>> createState() => _WithViewStoreState<S, A>();
}

class _WithViewStoreState<S, A> extends State<WithViewStore<S, A>> {
  SyncStreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    widget.onInitState?.call(widget.store);
    _subscription?.cancel();
    _subscription = widget.store.syncStream.listen((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.body(widget.store);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
