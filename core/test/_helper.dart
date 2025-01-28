// ignore: must_be_immutable
import 'package:composable_architecture/core.dart';

// ignore: must_be_immutable
final class AppState extends Equatable {
  int count;

  AppState({this.count = 0});

  AppState copyWith({required int count}) {
    return AppState(count: count);
  }

  @override
  List<Object?> get props => [count];
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
