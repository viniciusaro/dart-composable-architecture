import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tca_flutter_example/app/clients.dart';
import 'package:tca_flutter_example/app/models.fixtures.dart';

import 'files.dart';
import 'home.dart';
import 'login.dart';

part 'app.g.dart';

@CaseKeyPathable()
sealed class AppDestination<
  Home extends HomeState, //
  Login extends LoginState
> {}

@KeyPathable()
final class AppState with _$AppState, Presentable {
  @override
  final Presents<AppDestination> destination;

  AppState({
    Presents<AppDestination>? destination, //
  }) : destination = destination ?? Presents(AppDestinationEnum.home());
}

@CaseKeyPathable()
sealed class AppAction<
  Home extends HomeAction,
  Login extends LoginAction //
> {}

final class AppFeature extends Feature<AppState, AppAction> {
  @override
  Reducer<AppState, AppAction> build() {
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
    ]);
  }
}

final class AppWidget extends StatelessWidget {
  final Store<AppState, AppAction> store;

  const AppWidget({super.key, required this.store});

  @override
  Widget build(Object context) {
    return WithViewStore(
      store,
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final prefs = await SharedPreferences.getInstance();
  // sharedPreferencesClient = LiveSharedPreferencesClient(prefs);
  sharedPreferencesClient = InMemoryPreferencesClient.list([
    sharedFile0,
    sharedFile1,
  ]);

  runApp(
    MaterialApp(
      home: AppWidget(
        store: Store(
          initialState: AppState(),
          reducer: AppFeature(), //
        ),
      ),
    ),
  );
}
