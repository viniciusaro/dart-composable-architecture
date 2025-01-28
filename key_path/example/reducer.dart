import 'package:key_path/key_path.dart';

@KeyPathable()
final class AppState {
  int count;
  AppState(int? count) : count = count ?? 0;
}

enum AppAction {
  increment,
}

int counterReducer(int state, AppAction action) {
  switch (action) {
    case AppAction.increment:
      state += 1;
      return state;
  }
}

T identity<T>(T value) => value;

typedef Reducer<State, Action> = State Function(State, Action);

Reducer<GlobalState, GlobalAction> pullback<GlobalState, GlobalAction, LocalState, LocalAction>(
  Reducer<LocalState, LocalAction> other, {
  required LocalState Function(GlobalState) toLocalState,
  required GlobalState Function(LocalState) toGlobalState,
  required LocalAction Function(GlobalAction) toLocalAction,
  required GlobalAction Function(LocalAction) toGlobalAction,
}) {
  return (globalState, globalAction) {
    var localState = toLocalState(globalState);
    final localAction = toLocalAction(globalAction);
    localState = other(localState, localAction);
    globalState = toGlobalState(localState);
    return globalState;
  };
}

Reducer<GlobalState, GlobalAction> pullbackKP<GlobalState, GlobalAction, LocalState, LocalAction>(
  Reducer<LocalState, LocalAction> other, {
  required WritableKeyPath<GlobalState, LocalState> state,
  required LocalAction Function(GlobalAction) toLocalAction,
  required GlobalAction Function(LocalAction) toGlobalAction,
}) {
  return (globalState, globalAction) {
    var localState = state.get(globalState);
    final localAction = toLocalAction(globalAction);
    localState = other(localState, localAction);
    state.set(globalState, localState);
    return globalState;
  };
}

void main() {
  regularPullback();
  keyPathPullback();
}

void regularPullback() {
  final appReducer = pullback(
    counterReducer,
    toLocalState: (AppState appState) => appState.count,
    toGlobalState: (count) => AppState(count),
    toLocalAction: (AppAction action) => action,
    toGlobalAction: (AppAction action) => action,
  );

  final state = appReducer(AppState(0), AppAction.increment);
  print("state (regular): ${state.count}"); // 1
}

void keyPathPullback() {
  final appReducer = pullbackKP(
    counterReducer,
    state: AppState.countPath,
    toLocalAction: (AppAction action) => action,
    toGlobalAction: (AppAction action) => action,
  );

  final state = appReducer(AppState(0), AppAction.increment);
  print("state (key path): ${state.count}"); // 1
}
