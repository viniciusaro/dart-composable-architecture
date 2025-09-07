import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';

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
final class AppState with _$AppState {
  @override
  final Presents<AppDestination> destination;
  AppState({required this.destination});
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
      Scope(
        state: AppStatePath.destination.path(AppDestinationPath.home),
        action: AppActionPath.home,
        reducer: HomeFeature(),
      ),
      Scope(
        state: AppStatePath.destination.path(AppDestinationPath.login),
        action: AppActionPath.login,
        reducer: LoginFeature(),
      ),
    ]);
  }
}
