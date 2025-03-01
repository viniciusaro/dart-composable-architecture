part of 'store.dart';

typedef Reducer<State, Action> = Effect<Action> Function(State, Action);

extension ReducerChangeEquatable<State, Action> on Reducer<State, Action> {
  Reducer<State, Action> onChange<LocalState>({
    required LocalState Function(State) of,
    required void Function(State, LocalState) update,
  }) {
    return (state, action) {
      final previousValue = of(state);
      final previousHash =
          previousValue is Iterable ? Object.hashAll(previousValue) : previousValue.hashCode;
      final effect = this(state, action);
      final updatedValue = of(state);
      final updatedHash =
          updatedValue is Iterable ? Object.hashAll(updatedValue) : updatedValue.hashCode;
      if (previousHash != updatedHash) {
        update(state, updatedValue);
      }
      return effect;
    };
  }
}

Reducer<State, Action> debug<State, Action>(
  Reducer<State, Action> other,
) {
  return (state, action) {
    final msgHeader = "--------";
    final msgAction = "received action: $action";
    final previous = state.hashCode;
    final effect = other(state, action);
    final updated = state.hashCode;
    final msgUpdate = (previous != updated || identical(previous, updated))
        ? "state: $state"
        : "state: no changes detected";

    return Effect(() {
      print(msgHeader);
      print(msgAction);
      print(msgUpdate);
      return effect.builder();
    });
  };
}

Reducer<State, Action> combine<State, Action>(List<Reducer<State, Action>> reducers) {
  return (state, action) {
    return Effect.merge(
      reducers.map((reducer) => reducer(state, action)).toList(),
    );
  };
}

Reducer<GlobalState, GlobalAction> pullback<GlobalState, GlobalAction, LocalState, LocalAction>(
  Reducer<LocalState, LocalAction> other, {
  required WritableKeyPath<GlobalState, LocalState> state,
  required WritableKeyPath<GlobalAction, LocalAction?> action,
}) {
  return (globalState, globalAction) {
    final localState = state.get(globalState);
    final localAction = action.get(globalAction);
    if (localAction == null) {
      return Effect.none();
    }

    final localEffect = other(localState, localAction);
    globalState = state.set(globalState, localState);

    return localEffect.map((localAction) {
      action.set(globalAction, localAction);
      return globalAction;
    });
  };
}
