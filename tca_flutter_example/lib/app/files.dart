import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';

import 'models.dart';

part 'files.g.dart';

@KeyPathable()
final class FilesState with _$FilesState {
  @override
  final List<SharedFile> files;

  FilesState({required this.files});
}

@CaseKeyPathable()
sealed class FilesAction {}

final class FilesFeature extends Feature<FilesState, FilesAction> {
  @override
  Reducer<FilesState, FilesAction> build() {
    return Reduce((state, action) {
      switch (action) {
        //
      }
    });
  }
}
