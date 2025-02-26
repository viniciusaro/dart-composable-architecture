import 'package:composable_architecture/composable_architecture.dart';
import 'package:flutter/material.dart';

final class ViewStore<State, Action> {
  final Store<State, Action> _store;

  ViewStore(this._store);

  State get state => Inout(value: _store.state).value;

  void send(Action action) {
    _store.send(action);
  }

  Store<LocalState, LocalAction> view<LocalState, LocalAction>(
      {required WritableKeyPath<State, LocalState> state,
      required WritableKeyPath<Action, LocalAction?> action}) {
    return _store.view(state: state, action: action);
  }
}

class WithViewStore<S, A> extends StatefulWidget {
  final Store<S, A> _store;
  final Widget Function(ViewStore<S, A> store) body;
  final void Function(ViewStore<S, A> store)? onInitState;

  const WithViewStore(this._store, {super.key, this.onInitState, required this.body});

  @override
  State<WithViewStore<S, A>> createState() => _WithViewStoreState<S, A>();
}

class _WithViewStoreState<S, A> extends State<WithViewStore<S, A>> {
  SyncStreamSubscription? _subscription;
  late ViewStore<S, A> _viewStore;

  @override
  void initState() {
    super.initState();
    _viewStore = ViewStore(widget._store);
    widget.onInitState?.call(_viewStore);
    _subscription?.cancel();
    _subscription = widget._store.syncStream.listen((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.body(_viewStore);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
