import 'package:composable_architecture/composable_architecture.dart';

part '_helper_navigation.freezed.dart';
part '_helper_navigation.g.dart';

@freezed
@KeyPathable()
final class RootState with _$RootState {
  @override
  final AppState app;
  RootState({AppState? app}) : app = app ?? AppState();
}

@CaseKeyPathable()
sealed class RootAction<App extends AppAction> {}

final rootReducer = pullback(
  appReducer,
  state: RootStatePath.app,
  action: RootActionPath.app,
);

@CaseKeyPathable()
sealed class AppDestination<Detail extends DetailState> {}

@freezed
@KeyPathable()
final class AppState with _$AppState, Presentable {
  @override
  final Presents<AppDestination?> destination;
  AppState({Presents<AppDestination?>? destination})
      : destination = destination ?? Presents(null);
}

@CaseKeyPathable()
sealed class AppAction<
    OnDetailButtonTapped,
    Detail extends DetailAction //
    > {}

Effect<AppAction> appReducer(Inout<AppState> state, AppAction action) {
  switch (action) {
    case AppActionOnDetailButtonTapped():
      state.mutate(
        (s) => s.copyWith(
          destination: Presents(AppDestinationEnum.detail(DetailState())),
        ),
      );
      return Effect.none();
    case AppActionDetail():
      return Effect.none();
  }
}

@freezed
@KeyPathable()
final class DetailState with _$DetailState {}

@CaseKeyPathable()
sealed class DetailAction {}
