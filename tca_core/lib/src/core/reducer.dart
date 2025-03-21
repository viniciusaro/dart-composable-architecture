part of 'store.dart';

typedef Reducer<State, Action> = Effect<Action> Function(Inout<State>, Action);

final class Inout<T> {
  T _value;
  T get value => _value;

  bool _isMutationAllowed = false;
  bool _didCallMutate = false;
  Inout({required T value}) : _value = value;

  T mutate(T Function(T) mutation) {
    _didCallMutate = true;
    if (_isMutationAllowed) {
      _value = mutation(_value);
      return _value;
    } else {
      throw EffectfullStateMutation();
    }
  }
}

extension ReducerChangeEquatable<State, Action> on Reducer<State, Action> {
  Reducer<State, Action> onChange<LocalState>({
    required LocalState Function(State) of,
    required void Function(Inout<State>, LocalState) update,
  }) {
    return (state, action) {
      final previousValue = of(state._value);
      final effect = this(state, action);
      final updatedValue = of(state._value);
      if (previousValue != updatedValue) {
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
    final previous = state._value;
    final effect = other(state, action);
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
  };
}

Reducer<State, Action> combine<State, Action>(
  List<Reducer<State, Action>> reducers,
) {
  return (state, action) {
    return Effect.merge(
      reducers.map((reducer) => reducer(state, action)).toList(),
    );
  };
}

Reducer<GlobalState, GlobalAction>
    pullback<GlobalState, GlobalAction, LocalState, LocalAction>(
  Reducer<LocalState, LocalAction> other, {
  required WritableKeyPath<GlobalState, LocalState> state,
  required WritableKeyPath<GlobalAction, LocalAction?> action,
}) {
  return (globalState, globalAction) {
    final localState = Inout(value: state.get(globalState._value));
    final localAction = action.get(globalAction);
    if (localAction == null) {
      return Effect.none();
    }

    localState._isMutationAllowed = true;
    localState._didCallMutate = false;
    final localEffect = other(localState, localAction);
    localState._isMutationAllowed = false;
    globalState._value = state.set(globalState._value, localState._value);

    return localEffect.map((localAction) {
      globalAction = action.set(globalAction, localAction);
      return globalAction;
    });
  };
}

Reducer<GlobalState, GlobalAction>
    ifLet<GlobalState, GlobalAction, LocalState, LocalAction>(
  Reducer<LocalState, LocalAction> other, {
  required WritableKeyPath<GlobalState, LocalState?> state,
  required WritableKeyPath<GlobalAction, LocalAction?> action,
}) {
  return (globalState, globalAction) {
    final localStateRaw = state.get(globalState._value);
    final localAction = action.get(globalAction);
    if (localStateRaw == null || localAction == null) {
      return Effect.none();
    }

    final localState = Inout(value: localStateRaw);
    localState._isMutationAllowed = true;
    localState._didCallMutate = false;
    final localEffect = other(localState, localAction);
    localState._isMutationAllowed = false;
    globalState._value = state.set(globalState._value, localState._value);

    return localEffect.map((localAction) {
      globalAction = action.set(globalAction, localAction);
      return globalAction;
    });
  };
}
