import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

import 'clients/models/models.dart';
import 'shared.extensions.dart';

part 'files.g.dart';

@KeyPathable()
final class FilesState with _$FilesState {
  @override
  final files = SharedX.userPrefs(<SharedFile>[]);
}

@CaseKeyPathable()
sealed class FilesAction<
  OnAddFileButtonTapped //
> {}

final class FilesFeature extends Feature<FilesState, FilesAction> {
  @override
  Reducer<FilesState, FilesAction> build() {
    return Reduce((state, action) {
      switch (action) {
        case FilesActionOnAddFileButtonTapped():
          state.value.files.set(
            (f) => [
              ...f,
              SharedFile(
                file: File(
                  id: "${f.length + 1}",
                  name: "Arquivo ${f.length + 1}",
                  createdAt: DateTime.now().toString(),
                  path: "caminho/para/arquivo/${f.length + 1}/",
                ),
                participants: [],
              ),
            ],
          );
          return Effect.none();
      }
    });
  }
}

final class FilesWidget extends StatelessWidget {
  final Store<FilesState, FilesAction> store;

  const FilesWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return WithViewStore(
      store,
      body: (viewStore) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Arquivos"),
            actions: [
              IconButton(
                onPressed: () {
                  viewStore.send(FilesActionEnum.onAddFileButtonTapped());
                },
                icon: Icon(Icons.add),
              ),
            ],
          ),
          body: ListView(
            children:
                viewStore.state.files.value.map((f) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Nome: ${f.file.name}"),
                      Text("Id: ${f.file.id}"),
                      SizedBox(height: 16),
                    ], //
                  );
                }).toList(),
          ),
        );
      },
    );
  }
}
