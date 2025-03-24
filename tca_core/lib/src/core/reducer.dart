part of 'store.dart';

mixin Reducer<State, Action> {
  Effect<Action> run(Inout<State> state, Action action);
}

final class Reduce<State, Action> with Reducer<State, Action> {
  final Effect<Action> Function(Inout<State>, Action) _reducer;
  Reduce(this._reducer);

  static Reducer<State, Action> combine<State, Action>(
    Iterable<Reducer<State, Action>> reducers,
  ) {
    return Reduce(
      (state, action) => Effect.merge(
        reducers.map((r) => r.run(state, action)).toList(),
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
  final Reducer<LocalState, LocalAction> reducer;

  const Scope({
    required this.state,
    required this.action,
    required this.reducer,
  });

  @override
  Effect<Action> run(Inout<State> globalState, Action globalAction) {
    final localState = Inout(value: state.get(globalState._value));
    final localAction = action.get(globalAction);
    if (localAction == null) {
      return Effect.none();
    }

    localState._isMutationAllowed = true;
    localState._didCallMutate = false;
    final localEffect = reducer.run(localState, localAction);
    localState._isMutationAllowed = false;
    globalState._value = state.set(globalState._value, localState._value);

    return localEffect.map((localAction) {
      globalAction = action.set(globalAction, localAction);
      return globalAction;
    });
  }
}

final class IfLet<State, Action, LocalState, LocalAction>
    with Reducer<State, Action> {
  final WritableKeyPath<State, LocalState?> state;
  final WritableKeyPath<Action, LocalAction?> action;
  final Reducer<LocalState, LocalAction> reducer;

  const IfLet({
    required this.state,
    required this.action,
    required this.reducer,
  });

  @override
  Effect<Action> run(Inout<State> globalState, Action globalAction) {
    final localStateRaw = state.get(globalState._value);
    final localAction = action.get(globalAction);
    if (localStateRaw == null || localAction == null) {
      return Effect.none();
    }

    final localState = Inout(value: localStateRaw);
    localState._isMutationAllowed = true;
    localState._didCallMutate = false;
    final localEffect = reducer.run(localState, localAction);
    localState._isMutationAllowed = false;
    globalState._value = state.set(globalState._value, localState._value);

    return localEffect.map((localAction) {
      globalAction = action.set(globalAction, localAction);
      return globalAction;
    });
  }
}

final class Debug<State, Action> with Reducer<State, Action> {
  final Reducer<State, Action> reducer;
  Debug(this.reducer);

  @override
  Effect<Action> run(Inout<State> state, Action action) {
    final msgHeader = "--------";
    final msgAction = "received action: $action";
    final previous = state._value;
    final effect = reducer.run(state, action);
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

extension OnChangeReducer<State, Action, LocalAction>
    on Reducer<State, Action> {
  Reducer<State, Action> onChange<LocalState>({
    required LocalState Function(State) of,
    required void Function(Inout<State>, LocalState) update,
  }) {
    return Reduce((state, action) {
      final previousValue = of(state._value);
      final effect = run(state, action);
      final updatedValue = of(state._value);
      if (previousValue != updatedValue) {
        update(state, updatedValue);
      }
      return effect;
    });
  }
}

extension DebugableReducer<State, Action> on Reducer<State, Action> {
  Debug<State, Action> debug() => Debug<State, Action>(this);
}
