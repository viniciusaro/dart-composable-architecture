import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

import '../clients/auth_client.dart';
import '../clients/models/models.dart';

import 'files.dart';
import 'home.dart';
import 'login.dart';
import 'testimonial_compose.dart';
import 'testimonials.dart';

part 'app.g.dart';

typedef State = AppState;
typedef Action = AppAction;

@KeyPathable()
final class AppState with _$AppState, Presentable {
  @override
  final Presents<AppDestination> destination;

  @override
  final HomeState? homeState;

  AppState({this.homeState})
    : destination = Presents(AppDestinationEnum.login());

  AppState._({Presents<AppDestination>? destination})
    : destination = destination ?? Presents(AppDestinationEnum.login()),
      homeState = null;
}

@CaseKeyPathable()
sealed class AppDestination<
  Home extends HomeState, //
  Login extends LoginState
> {}

@CaseKeyPathable()
sealed class AppAction<
  OnAppStart,
  OnAuthResult extends AppDestination,
  Home extends HomeAction,
  Login extends LoginAction
> {}

final class AppFeature extends Feature<State, Action> {
  @override
  Reducer<State, Action> build() {
    return Reduce.combine([
      IfLet(
        state: AppStatePath.destination.path(AppDestinationPath.home),
        action: AppActionPath.home,
        reducer: HomeFeature(),
      ),
      IfLet(
        state: AppStatePath.destination.path(AppDestinationPath.login),
        action: AppActionPath.login,
        reducer: LoginFeature(),
      ),
      Reduce((state, action) {
        switch (action) {
          case AppActionOnAppStart():
            return Effect.future(() async {
              final result = await authClient.getAuthToken();
              if (result == null) {
                return AppActionEnum.onAuthResult(
                  AppDestinationEnum.login(), //
                );
              } else {
                return AppActionEnum.onAuthResult(
                  AppDestinationEnum.home(state.value.homeState),
                );
              }
            });
          case AppActionOnAuthResult():
            state.mutate(
              (s) => s.copyWith(destination: Presents(action.onAuthResult)),
            );
            return Effect.none();
          case AppActionLogin():
            final loginAction = action.login;
            switch (loginAction) {
              case LoginActionOnLoggedIn():
                state.mutate(
                  (s) => s.copyWith(
                    destination: Presents(
                      AppDestinationEnum.home(state.value.homeState),
                    ),
                  ),
                );
                return Effect.none();
              case LoginActionOnLoginButtonTapped():
                return Effect.none();
            }
          default:
            return Effect.none();
        }
      }),
    ]);
  }
}

final class AppWidget extends StatelessWidget {
  final Store<State, Action> store;

  const AppWidget({super.key, required this.store});

  @override
  Widget build(Object context) {
    return WithViewStore(
      store,
      onInitState: (viewStore) {
        viewStore.send(AppActionEnum.onAppStart());
      },
      body: (viewStore) {
        switch (viewStore.state.destination.value) {
          case AppDestinationHome():
            final store = viewStore.view(
              state: AppStatePath.destination.path(AppDestinationPath.home),
              action: AppActionPath.home,
            );
            return HomeWidget(store: store!);
          case AppDestinationLogin():
            final store = viewStore.view(
              state: AppStatePath.destination.path(AppDestinationPath.login),
              action: AppActionPath.login,
            );
            return LoginWidget(store: store!);
        }
      },
    );
  }
}
