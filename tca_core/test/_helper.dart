// ignore: must_be_immutable
import 'package:composable_architecture/composable_architecture.dart';

const unit = Unit._();

final class Unit {
  const Unit._();
}

final class AppState extends Equatable {
  int count = 0;

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

Effect<AppAction> counterReducer(AppState state, AppAction action) {
  switch (action) {
    case AppAction.actionA:
      state.count += 1;
      return Effect.none();
    case AppAction.actionB:
      state.count -= 1;
      return Effect.none();
  }
}
