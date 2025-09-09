import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

import 'files.dart';

part 'home.g.dart';

@KeyPathable()
final class HomeState with _$HomeState {
  @override
  final FilesState files;

  HomeState({FilesState? files}) : files = files ?? FilesState();
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

final class HomeWidget extends StatelessWidget {
  final Store<HomeState, HomeAction> store;

  const HomeWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return WithViewStore(
      store,
      body: (viewStore) {
        final filesStore = viewStore.view(
          state: HomeStatePath.files,
          action: HomeActionPath.files,
        );

        return DefaultTabController(
          length: 1,
          child: Scaffold(
            body: TabBarView(
              children: [
                FilesWidget(store: filesStore), //
              ],
            ),
            bottomNavigationBar: const Material(
              child: SafeArea(
                child: TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.home), text: "Arquivos"), //
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
