import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

part 'favorites.g.dart';

@KeyPathable()
class FavoritesState with _$FavoritesState {
  @override
  final Shared<Set<int>> favorites;

  FavoritesState({Shared<Set<int>>? favorites})
    : favorites = favorites ?? Shared(InMemorySource({}));
}

@CaseKeyPathable()
sealed class FavoritesAction<
  Remove extends int //
> {}

final class FavoritesFeature extends Feature<FavoritesState, FavoritesAction> {
  @override
  Reducer<FavoritesState, FavoritesAction> build() {
    return Reduce((state, action) {
      switch (action) {
        case FavoritesActionRemove():
          state.mutate(
            (s) => s.copyWith(
              favorites: s.favorites.set(
                (curr) => curr.where((c) => c != action.remove).toSet(),
              ),
            ),
          );
          return Effect.none();
      }
    });
  }
}

class FavoritesWidget extends StatelessWidget {
  final Store<FavoritesState, FavoritesAction> store;

  const FavoritesWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorites")),
      body: WithViewStore(
        store,
        body: (viewStore) {
          final items = viewStore.state.favorites;
          return ListView.builder(
            itemCount: items.value.length,
            itemBuilder: (context, index) {
              final item = items.value.toList()[index];
              return Dismissible(
                key: Key(item.toString()),
                child: ListTile(title: Text("$item")),
                onDismissed: (direction) {
                  viewStore.send(FavoritesActionEnum.remove(item));
                },
              );
            },
          );
        },
      ),
    );
  }
}
