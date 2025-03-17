import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';

part 'optional_state.freezed.dart';
part 'optional_state.g.dart';

@CaseKeyPathable()
sealed class AppDestination<
  Login extends LoginState,
  Home extends HomeState //
> {}

@freezed
@KeyPathable()
final class AppState with _$AppState {
  @override
  final AppDestination destination;
  AppState({AppDestination? destination})
    : destination = destination ?? AppDestinationEnum.login(LoginState());
}

@CaseKeyPathable()
sealed class AppAction<
  Login extends LoginAction,
  Home extends HomeAction //
> {}

final Reducer<AppState, AppAction> appReducer = combine([
  ifLet(
    loginReducer,
    state: AppStatePath.destination.path(AppDestinationPath.login),
    action: AppActionPath.login,
  ),
  ifLet(
    homeReducer,
    state: AppStatePath.destination.path(AppDestinationPath.home),
    action: AppActionPath.home,
  ),
  (state, action) {
    switch (action) {
      case AppActionLogin():
        switch (action.login) {
          case LoginActionOnSignInSucceeded():
            state.mutate(
              (s) => s.copyWith(
                destination: AppDestinationEnum.home(HomeState()), //
              ),
            );
            return Effect.none();
          default:
            return Effect.none();
        }
      case AppActionHome():
        switch (action.home) {
          case HomeActionOnSignOutButtonTapped():
            state.mutate(
              (s) => s.copyWith(
                destination: AppDestinationEnum.login(LoginState()),
              ),
            );
            return Effect.none();
        }
    }
  },
]);

class AppWidget extends StatelessWidget {
  final Store<AppState, AppAction> store;

  const AppWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return WithViewStore(
      store,
      body: (viewStore) {
        switch (viewStore.state.destination) {
          case AppDestinationLogin():
            final store = viewStore.viewOptional(
              state: AppStatePath.destination.path(AppDestinationPath.login),
              action: AppActionPath.login,
            );
            return LoginWidget(store: store!);
          case AppDestinationHome():
            final store = viewStore.viewOptional(
              state: AppStatePath.destination.path(AppDestinationPath.home),
              action: AppActionPath.home,
            );
            return HomeWidget(store: store!);
        }
      },
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: AppWidget(
          store: Store(
            initialState: AppState(),
            reducer: debug(appReducer), //
          ),
        ),
      ),
    ),
  );
}
