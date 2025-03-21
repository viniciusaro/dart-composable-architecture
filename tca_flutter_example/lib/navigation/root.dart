import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

import 'edit.dart';
import 'item.dart';
import 'navigation.dart';

part 'root.freezed.dart';
part 'root.g.dart';

@freezed
@KeyPathable()
final class RootState with _$RootState {
  @override
  final AppState app;
  RootState({AppState? app}) : app = app ?? AppState();
}

@CaseKeyPathable()
sealed class RootAction<
  App extends AppAction //
> {}

final rootReducer = pullback(
  appReducer,
  state: RootStatePath.app,
  action: RootActionPath.app,
);

class RootWidget extends StatelessWidget {
  final Store<RootState, RootAction> store;

  const RootWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return WithViewStore(
      store,
      body: (store) {
        return AppWidget(
          store: store.view(
            state: RootStatePath.app,
            action: RootActionPath.app,
          ),
        );
      },
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: RootWidget(
        store: Store(
          initialState: RootState(
            app: AppState(
              items: [
                Item(id: 1, name: "Item 1"),
                Item(id: 2, name: "Item 2"),
                Item(id: 3, name: "Item 3"),
              ],
            ),
          ),
          reducer: debug(rootReducer),
        ),
      ),
    ),
  );
}
