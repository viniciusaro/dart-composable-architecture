import 'package:composable_architecture/composable_architecture.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tca_flutter_example/navigation/edit.dart';
import 'package:tca_flutter_example/navigation/item.dart';
import 'package:tca_flutter_example/navigation/navigation.dart';

void main() {
  test(
    'on edit complete, original item is updated and destination is cleaned up',
    () {
      final item1 = Item(id: 1, name: "1");

      final store = TestStore(
        initialState: AppState(items: [item1]),
        reducer: appReducer,
      );

      store.send(
        AppActionEnum.editItemButtonTapped(item1),
        (state) => state.copyWith(
          destination: Presents(
            AppDestinationEnum.edit(EditState(item: item1)),
          ),
        ),
      );

      store.send(
        AppActionEnum.edit(
          EditActionEnum.onEditComplete(Item(id: 1, name: "1 + 1")),
        ),
        (state) => state.copyWith(
          items: [Item(id: 1, name: "1 + 1")],
          destination: Presents(null),
        ),
      );
    },
  );
}
