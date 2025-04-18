// ignore: must_be_immutable
import 'package:composable_architecture/composable_architecture.dart';

const unit = Unit._();

final class Unit {
  const Unit._();
}

// ignore: must_be_immutable
final class AppState {
  int count;

  AppState({this.count = 0});

  AppState copyWith({required int count}) {
    return AppState(count: count);
  }

  @override
  String toString() {
    return "AppState($count)";
  }

  @override
  int get hashCode => count.hashCode ^ 31;

  @override
  bool operator ==(Object other) {
    return other is AppState && other.count == count;
  }
}

enum AppAction {
  actionA,
  actionB,
}

Effect<AppAction> infinitActionAEffect() => Effect.stream(
      () async* {
        while (true) {
          await Future.delayed(Duration(milliseconds: 10));
          yield AppAction.actionA;
        }
      },
    );

Effect<AppAction> counterReducer(Inout<AppState> state, AppAction action) {
  switch (action) {
    case AppAction.actionA:
      state.mutate((s) => s.copyWith(count: s.count + 1));
      return Effect.none();
    case AppAction.actionB:
      state.mutate((s) => s.copyWith(count: s.count - 1));
      return Effect.none();
  }
}

Effect<AppAction> intCounterReducer(Inout<int> state, AppAction action) {
  switch (action) {
    case AppAction.actionA:
      state.mutate((s) => s + 1);
      return Effect.none();
    case AppAction.actionB:
      state.mutate((s) => s - 1);
      return Effect.none();
  }
}
