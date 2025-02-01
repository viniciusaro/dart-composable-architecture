import 'package:composable_architecture/composable_architecture.dart';
import 'package:flutter/material.dart';

class WithViewStore<S, A> extends StatefulWidget {
  final Store<S, A> _store;
  final Widget Function(Store<S, A> store) body;

  const WithViewStore(this._store, {super.key, required this.body});

  @override
  State<WithViewStore<S, A>> createState() => _WithViewStoreState<S, A>();
}

class _WithViewStoreState<S, A> extends State<WithViewStore<S, A>> {
  SyncStreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription?.cancel();
    _subscription = widget._store.syncStream.listen((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.body(widget._store);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    widget._store.close();
    super.dispose();
  }
}
