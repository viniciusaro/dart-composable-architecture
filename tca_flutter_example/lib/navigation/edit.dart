import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

import 'item.dart';

part 'edit.freezed.dart';
part 'edit.g.dart';

@freezed
@KeyPathable()
final class EditState with _$EditState {
  @override
  final Item item;
  EditState({required this.item});
}

@CaseKeyPathable()
sealed class EditAction<
  OnEditCancelled,
  OnEditComplete extends Item //
> {}

class EditWiget extends StatelessWidget {
  final Store<EditState, EditAction> store;

  const EditWiget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            store.send(
              EditActionEnum.onEditComplete(
                Item(
                  id: store.state.item.id,
                  name: "${store.state.item.name} + 1",
                ),
              ),
            );
          },
          child: Text("Increment and finish"),
        ),
      ),
    );
  }
}
