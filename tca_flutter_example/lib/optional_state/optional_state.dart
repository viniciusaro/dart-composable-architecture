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
final class AppState with _$AppState, Presentable {
  @override
  final Presents<AppDestination> destination;

  AppState({Presents<AppDestination>? destination})
    : destination =
          destination ?? Presents(AppDestinationEnum.login(LoginState()));
}

@CaseKeyPathable()
sealed class AppAction<
  Login extends LoginAction,
  Home extends HomeAction //
> {}

final class AppFeature extends Feature<AppState, AppAction> {
  @override
  Reducer<AppState, AppAction> build() {
    return Reduce.combine([
      IfLet(
        state: AppStatePath.destination.path(AppDestinationPath.login),
        action: AppActionPath.login,
        feature: LoginFeature(),
      ),
      IfLet(
        state: AppStatePath.destination.path(AppDestinationPath.home),
        action: AppActionPath.home,
        feature: HomeFeature(),
      ),
      Reduce((state, action) {
        switch (action) {
          case AppActionLogin():
            switch (action.login) {
              case LoginActionOnSignInSucceeded():
                state.mutate(
                  (s) => s.copyWith(
                    destination: Presents(
                      AppDestinationEnum.home(HomeState()), //
                    ),
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
                    destination: Presents(
                      AppDestinationEnum.login(LoginState()),
                    ),
                  ),
                );
                return Effect.none();
            }
        }
      }),
    ]);
  }
}

class AppWidget extends StatelessWidget {
  final Store<AppState, AppAction> store;

  const AppWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return WithViewStore(
      store,
      body: (viewStore) {
        switch (viewStore.state.destination.value) {
          case AppDestinationLogin():
            final store = viewStore.view(
              state: AppStatePath.destination.path(AppDestinationPath.login),
              action: AppActionPath.login,
            );
            return LoginWidget(store: store!);
          case AppDestinationHome():
            final store = viewStore.view(
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
            reducer: AppFeature().debug(), //
          ),
        ),
      ),
    ),
  );
}
