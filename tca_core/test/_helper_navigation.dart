import 'package:composable_architecture/composable_architecture.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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

final class RootFeature extends Feature<RootState, RootAction> {
  @override
  Reducer<RootState, RootAction> build() {
    return Scope(
      state: RootStatePath.app,
      action: RootActionPath.app,
      reducer: AppFeature(),
    );
  }
}

@CaseKeyPathable()
sealed class AppDestination<
    Detail extends DetailState //
    > {}

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

final class AppFeature extends Feature<AppState, AppAction> {
  @override
  Reducer<AppState, AppAction> build() {
    return Reduce((state, action) {
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
    });
  }
}

@KeyPathable()
final class DetailState with _$DetailState {}

@CaseKeyPathable()
sealed class DetailAction {}
