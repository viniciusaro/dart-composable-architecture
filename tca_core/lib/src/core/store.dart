import 'dart:async';
import 'dart:isolate';

import 'package:equatable/equatable.dart';

import '../helpers/sync_stream.dart';

part 'exceptions.dart';
part 'effect.dart';
part 'key_path.dart';
part 'reducer.dart';

final class StateUpdate<State> {
  final State state;
  final bool fromChild;
  const StateUpdate(this.state, this.fromChild);
}

final class Store<State, Action> {
  final Reducer<State, Action> _reducer;
  State state;
  final syncStream = SyncStream<StateUpdate<State>>();

  Store({
    required State initialState,
    required Reducer<State, Action> reducer,
  })  : state = initialState,
        _reducer = reducer;

  void send(Action action) {
    _send(action);
  }

  void _send(Action action, {bool fromChild = false}) {
    final effect = _reducer(state, action);
    syncStream.add(StateUpdate(state, fromChild));
    final stream = effect.builder();
    final id = _cancellableEffects[effect._cancellableId];

    final subscription = stream.listen(send);

    if (id != null) {
      _effectSubscriptions[id] = subscription;
    }
  }

  Store<LocalState, LocalAction> view<LocalState, LocalAction>({
    required WritableKeyPath<State, LocalState> state,
    required WritableKeyPath<Action, LocalAction?> action,
  }) {
    final store = Store<LocalState, LocalAction>(
      initialState: state.get(this.state),
      reducer: (localState, localAction) {
        final globalAction = action.set(null, localAction);
        _send(globalAction, fromChild: true);
        return Effect.none();
      },
    );

    syncStream.listen((update) {
      store.state = state.get(update.state);
      if (!update.fromChild) {
        store.syncStream.add(StateUpdate(state.get(update.state), false));
      }
    });

    return store;
  }
}

final class TestStore<State, Action> {
  State state;
  final Reducer<State, Action> _reducer;
  final List<Action> _expectedActions = [];
  final List<State Function(State)> _expectedStateUpdates = [];

  TestStore({required State initialState, required Reducer<State, Action> reducer})
      : _reducer = reducer,
        state = initialState;

  Future<void> send(Action action, State Function(State) updates) async {
    final isolatedState = await Isolate.run(() => state);

    final (afterUpdatesHashCode, afterUpdatesDescripton) = () {
      final updated = updates(isolatedState);
      return (updated.hashCodeConsideringContents, updated.toString());
    }();

    final effect = _reducer(state, action);
    if (state.hashCodeConsideringContents != afterUpdatesHashCode) {
      throw Exception("Detected unexpected changes. Expected $afterUpdatesDescripton, got: $state");
    }

    final stream = effect.builder();
    final id = _cancellableEffects[effect._cancellableId];

    final subscription = stream.listen((action) {
      if (_expectedActions.isEmpty) {
        throw Exception("Received unexpected action: $action");
      }
      final expectedAction = _expectedActions.removeAt(0);
      final expectedUpdates = _expectedStateUpdates.removeAt(0);
      if (expectedAction != action) {
        throw Exception("Received unexpected action: $action");
      } else {
        _expectedActions.remove(action);
      }
      send(action, expectedUpdates);
    });

    if (id != null) {
      _effectSubscriptions[id] = subscription;
    }
  }

  Future<void> receive(Action action, State Function(State) updates) async {
    _expectedActions.add(action);
    _expectedStateUpdates.add(updates);
    await Future.delayed(Duration(milliseconds: 1));
  }
}

extension ObjectX<T> on T {
  int get hashCodeConsideringContents {
    final self = this;
    return self is Iterable ? Object.hashAll(self) : self.hashCode;
  }
}
