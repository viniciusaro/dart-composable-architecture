part of 'store.dart';

mixin Reducer<State, Action> {
  Effect<Action> run(Inout<State> state, Action action);
}

final class Reduce<State, Action> with Reducer<State, Action> {
  final Effect<Action> Function(Inout<State>, Action) _reducer;
  Reduce(this._reducer);

  static Reducer<State, Action> combine<State, Action>(
    List<Reducer<State, Action>> reduces,
  ) {
    return Reduce(
      (state, action) => Effect.merge(
        reduces.map((r) => r.run(state, action)).toList(),
      ),
    );
  }

  @override
  Effect<Action> run(Inout<State> state, Action action) {
    return _reducer(state, action);
  }
}

final class EmptyReducer<State, Action> with Reducer<State, Action> {
  @override
  Effect<Action> run(Inout<State> state, Action action) {
    return Effect.none();
  }
}

final class Scope<State, Action, LocalState, LocalAction>
    with Reducer<State, Action> {
  final WritableKeyPath<State, LocalState> state;
  final WritableKeyPath<Action, LocalAction?> action;
  final Feature<LocalState, LocalAction> feature;

  const Scope({
    required this.state,
    required this.action,
    required this.feature,
  });

  @override
  Effect<Action> run(Inout<State> state, Action action) {
    final localAction = this.action.get(action);
    if (localAction == null) {
      return Effect.none();
    }

    final localState = this.state.get(state.value);
    final inoutLocalState = Inout(value: localState);
    inoutLocalState._isMutationAllowed = true;
    final effect = feature.build().run(inoutLocalState, localAction);
    inoutLocalState._isMutationAllowed = false;
    state._value = this.state.set(state._value, inoutLocalState._value);
    return effect.map((localAction) {
      return this.action.set(null, localAction);
    });
  }
}

final class IfLet<State, Action, LocalState, LocalAction>
    with Reducer<State, Action> {
  final WritableKeyPath<State, LocalState?> state;
  final WritableKeyPath<Action, LocalAction?> action;
  final Feature<LocalState, LocalAction> feature;

  const IfLet({
    required this.state,
    required this.action,
    required this.feature,
  });

  @override
  Effect<Action> run(Inout<State> state, Action action) {
    final localAction = this.action.get(action);
    final localState = this.state.get(state.value);
    if (localAction == null || localState == null) {
      return Effect.none();
    }
    final inoutLocalState = Inout(value: localState);
    inoutLocalState._isMutationAllowed = true;
    final effect = feature.build().run(inoutLocalState, localAction);
    inoutLocalState._isMutationAllowed = false;
    state._value = this.state.set(state._value, inoutLocalState._value);
    return effect.map((localAction) {
      return this.action.set(null, localAction);
    });
  }
}

final class Debug<State, Action> with Reducer<State, Action> {
  final Reducer<State, Action> _source;
  Debug(this._source);

  @override
  Effect<Action> run(Inout<State> state, Action action) {
    final msgHeader = "--------";
    final msgAction = "received action: $action";
    final previous = state._value;
    final effect = _source.run(state, action);
    final updated = state._value;
    final msgUpdate = (previous != updated || identical(previous, updated))
        ? "state: $updated"
        : "state: no changes detected";

    return Effect(() {
      print(msgHeader);
      print(msgAction);
      print(msgUpdate);
      return effect.builder();
    });
  }
}

extension DebugableReducer<State, Action> on Reducer<State, Action> {
  Debug<State, Action> debug() => Debug<State, Action>(this);
}
