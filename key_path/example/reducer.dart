import 'package:key_path/key_path.dart';

@KeyPathable()
final class AppState {
  CounterState counter = CounterState();
  FavoritesState favorites = FavoritesState();
}

@CaseKeyPathable()
abstract class AppAction<
    OnViewAppear,
    Counter extends CounterAction,
    Favorites extends FavoritesAction //
    > {}

@KeyPathable()
final class CounterState {
  int count = 0;
}

@CaseKeyPathable()
abstract class CounterAction<
    Increment,
    Decrement //
    > {}

final class FavoritesState {
  List<int> favorites = [];
}

@CaseKeyPathable()
abstract class FavoritesAction<
    Add extends AddToFavorites,
    Remove extends RemoveFromFavorites //
    > {}

class AddToFavorites {
  final int number;
  AddToFavorites(this.number);
}

class RemoveFromFavorites {
  final int index;
  RemoveFromFavorites(this.index);
}

CounterState counterReducer(CounterState state, CounterAction action) {
  switch (action) {
    case CounterActionIncrement():
      state.count += 1;
      return state;
    case CounterActionDecrement():
      state.count -= 1;
      return state;
  }
  throw Exception("invalid action");
}

FavoritesState favoritesReducer(FavoritesState state, FavoritesAction action) {
  switch (action) {
    case FavoritesActionAdd():
      state.favorites.add(action.add.number);
      return state;
    case FavoritesActionRemove():
      state.favorites.removeAt(action.remove.index);
      return state;
  }
  throw Exception("invalid action");
}

typedef Reducer<State, Action> = State Function(State, Action);

Reducer<State, Action> combine<State, Action>(List<Reducer<State, Action>> reducers) {
  return (state, action) {
    for (final reducer in reducers) {
      state = reducer(state, action);
    }
    return state;
  };
}

Reducer<GlobalState, GlobalAction> pullback<GlobalState, GlobalAction, LocalState, LocalAction>(
  Reducer<LocalState, LocalAction> other, {
  required WritableKeyPath<GlobalState, LocalState> state,
  required KeyPath<GlobalAction, LocalAction?> action,
}) {
  return (globalState, globalAction) {
    var localState = state.get(globalState);
    final localAction = action.get(globalAction);

    if (localAction == null) {
      return globalState;
    }

    localState = other(localState, localAction);
    state.set(globalState, localState);
    return globalState;
  };
}

void main() {
  final Reducer<AppState, AppAction> appReducer = combine([
    pullback(
      counterReducer,
      state: AppState.counterPath,
      action: AppAction.counterPath,
    ),
    pullback(
      favoritesReducer,
      state: AppState.favoritesPath,
      action: AppAction.favoritesPath,
    ),
  ]);

  var state = AppState();
  state = appReducer(state, AppAction.counter(CounterAction.increment()));
  state = appReducer(state, AppAction.favorites(FavoritesAction.add(AddToFavorites(1))));
  state = appReducer(state, AppAction.favorites(FavoritesAction.add(AddToFavorites(2))));
  print("count: ${state.counter.count}"); // 1
  print("favorites: ${state.favorites.favorites}"); // [1, 2]
}
