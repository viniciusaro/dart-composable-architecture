import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';

import 'files.dart';

part 'home.g.dart';

@KeyPathable()
final class HomeState with _$HomeState {
  @override
  final FilesState files;

  HomeState({required this.files});
}

@CaseKeyPathable()
sealed class HomeAction<
  Files extends FilesAction //
> {}

final class HomeFeature extends Feature<HomeState, HomeAction> {
  @override
  Reducer<HomeState, HomeAction<FilesAction>> build() {
    return Reduce.combine([
      Scope(
        state: HomeStatePath.files,
        action: HomeActionPath.files,
        reducer: FilesFeature(),
      ),
    ]);
  }
}
