import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

part 'favorites.freezed.dart';
part 'favorites.g.dart';

@freezed
@KeyPathable()
abstract class FavoritesState with _$FavoritesState {
  const factory FavoritesState({
    @Default({}) Set<int> favorites, //
  }) = _FavoritesState;
}

@CaseKeyPathable()
sealed class FavoritesAction<
  Remove extends int //
> {}

Effect<FavoritesAction> favoritesReducer(Inout<FavoritesState> state, FavoritesAction action) {
  switch (action) {
    case FavoritesActionRemove():
      state.mutate(
        (s) => s.copyWith(favorites: s.favorites.where((e) => e != action.remove).toSet()),
      );
      return Effect.none();
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
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items.toList()[index];
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
