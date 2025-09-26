import 'package:composable_architecture/composable_architecture.dart';
import 'package:flutter/material.dart';

class WithViewStore<S, A, Prop> extends StatefulWidget {
  final Store<S, A> store;
  final void Function(Store<Prop, A> store)? onInitState;
  final Widget Function(Store<Prop, A> store) body;
  final WritableKeyPath<S, Prop> prop;

  const WithViewStore(
    this.store, {
    super.key,
    this.onInitState,
    required this.body,
    required this.prop,
  });

  static WithViewStore<S, A, S> identity<S, A>(
    Store<S, A> store, {
    void Function(Store<S, A> store)? onInitState,
    required Widget Function(Store<S, A> store) body,
  }) {
    return WithViewStore<S, A, S>(
      store,
      onInitState: onInitState,
      body: body,
      prop: KeyPath.identity<S>(),
    );
  }

  @override
  State<WithViewStore<S, A, Prop>> createState() =>
      _WithViewStoreState<S, A, Prop>();
}

class _WithViewStoreState<S, A, Prop> extends State<WithViewStore<S, A, Prop>> {
  SyncStreamSubscription? _subscription;
  late Store<Prop, A> _propStore;

  @override
  void initState() {
    super.initState();
    _propStore = widget.store.view(
      state: widget.prop,
      action: KeyPath.identityOptional<A>(),
    );

    widget.onInitState?.call(_propStore);
    _subscription?.cancel();
    _subscription = widget.store.syncStream.listen((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.body(_propStore);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
