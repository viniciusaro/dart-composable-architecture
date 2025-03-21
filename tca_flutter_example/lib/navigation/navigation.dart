import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart' hide NavigationDestination;

import 'edit.dart';
import 'item.dart';

part 'navigation.freezed.dart';
part 'navigation.g.dart';

@CaseKeyPathable()
sealed class AppDestination<
  Edit extends EditState //
> {}

@freezed
@KeyPathable()
final class AppState with _$AppState, Presentable {
  @override
  final List<Item> items;

  @override
  final Presents<AppDestination?> destination;

  AppState({this.items = const [], Presents<AppDestination?>? destination})
    : destination = destination ?? Presents(null);
}

@CaseKeyPathable()
sealed class AppAction<
  EditItemButtonTapped extends Item, //
  Edit extends EditAction //
> {}

Effect<AppAction> appReducer(Inout<AppState> state, AppAction action) {
  switch (action) {
    case AppActionEditItemButtonTapped():
      final item = action.editItemButtonTapped;
      state.mutate(
        (s) => s.copyWith(
          destination: Presents(AppDestinationEnum.edit(EditState(item: item))),
        ),
      );
      return Effect.none();
    case AppActionEdit():
      final edit = action.edit;
      switch (edit) {
        case EditActionOnEditComplete():
          state.mutate((s) {
            return s.copyWith(
              items: s.items.replacingWhere(
                (e) => e.id == edit.onEditComplete.id,
                withValue: edit.onEditComplete,
              ),
              destination: Presents(null),
            );
          });
        case EditActionOnEditCancelled():
          state.mutate((s) => s.copyWith(destination: Presents(null)));
      }
      return Effect.none();
  }
}

extension ReplaceableList<T> on List<T> {
  List<T> replacingWhere(bool Function(T) value, {required T withValue}) {
    return map((e) => value(e) ? withValue : e).toList();
  }
}

class AppWidget extends StatelessWidget {
  final Store<AppState, AppAction> store;

  const AppWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return WithViewStore(
      store,
      body: (store) {
        final tiles = store.state.items.map(
          (item) => ListTile(
            title: Text(item.name),
            onTap: () => store.send(AppActionEnum.editItemButtonTapped(item)),
          ),
        );

        return NavigationDestination(
          store.view(
            state: AppStatePath.destination.path(AppDestinationPath.edit),
            action: AppActionPath.edit,
          ),
          builder: (context, store) {
            return EditWiget(store: store);
          },
          child: Scaffold(
            appBar: AppBar(title: Text("Navigation")),
            body: ListView(children: tiles.toList()),
          ),
        );
      },
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: AppWidget(
        store: Store(
          initialState: AppState(
            items: [
              Item(id: 1, name: "Item 1"),
              Item(id: 2, name: "Item 2"),
              Item(id: 3, name: "Item 3"),
            ],
          ),
          reducer: debug(appReducer),
        ),
      ),
    ),
  );
}
