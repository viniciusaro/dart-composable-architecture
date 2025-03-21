import 'package:composable_architecture/composable_architecture.dart';
import 'package:test/test.dart';

import '_helper_navigation.dart';

void main() {
  test('presents value is cleaned up on child store dispose', () {
    final store = Store(initialState: AppState(), reducer: appReducer);
    store.send(AppActionEnum.onDetailButtonTapped());
    expect(
      store.state,
      AppState(destination: Presents(AppDestinationEnum.detail(DetailState()))),
    );

    final detailStore = store.view(
      state: AppStatePath.destination.path(AppDestinationPath.detail),
      action: AppActionPath.detail,
    );
    detailStore!.dispose();

    expect(
      store.state,
      AppState(destination: Presents(null)),
    );
  });

  test('presents value clean up is propagated up in the tree', () {
    final store = Store(initialState: RootState(), reducer: rootReducer);
    store.send(RootActionEnum.app(AppActionEnum.onDetailButtonTapped()));
    expect(
      store.state,
      RootState(
        app: AppState(
          destination: Presents(AppDestinationEnum.detail(DetailState())),
        ),
      ),
    );

    final appStore = store.view(
      state: RootStatePath.app,
      action: RootActionPath.app,
    );

    final detailStore = appStore.view(
      state: AppStatePath.destination.path(AppDestinationPath.detail),
      action: AppActionPath.detail,
    );

    detailStore!.dispose();

    expect(
      appStore.state,
      AppState(destination: Presents(null)),
    );

    expect(
      store.state,
      RootState(app: AppState(destination: Presents(null))),
    );
  });
}
