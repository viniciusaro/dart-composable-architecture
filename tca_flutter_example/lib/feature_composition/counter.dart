import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

part 'counter.g.dart';

@KeyPathable()
class CounterState with _$CounterState {
  @override
  final int count;

  @override
  final Shared<Set<int>> favorites;

  CounterState({int? count, Shared<Set<int>>? favorites})
    : count = count ?? 0,
      favorites = favorites ?? Shared(InMemorySource({}));
}

@CaseKeyPathable()
sealed class CounterAction<
  AddToFavoritesButtonTapped,
  IncrementButtonTapped,
  DecrementButtonTapped,
  RemoveFromFavoritesButtonTapped //
> {}

final class CounterFeature extends Feature<CounterState, CounterAction> {
  @override
  Reducer<CounterState, CounterAction> build() {
    return Reduce((state, action) {
      switch (action) {
        case CounterActionAddToFavoritesButtonTapped():
          state.mutate(
            (s) => s.copyWith(
              favorites: s.favorites.set((curr) => {...curr, s.count}),
            ),
          );
          return Effect.none();
        case CounterActionIncrementButtonTapped():
          state.mutate((s) => s.copyWith(count: s.count + 1));
          return Effect.none();
        case CounterActionDecrementButtonTapped():
          state.mutate((s) => s.copyWith(count: s.count - 1));
          return Effect.none();
        case CounterActionRemoveFromFavoritesButtonTapped():
          state.mutate(
            (s) => s.copyWith(
              favorites: s.favorites.set(
                (curr) => curr.where((c) => c != s.count).toSet(),
              ),
            ),
          );
          return Effect.none();
      }
    });
  }
}

class CounterWidget extends StatelessWidget {
  final Store<CounterState, CounterAction> store;

  const CounterWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Count")),
      body: WithViewStore(
        store,
        body: (viewStore) {
          return Center(
            child: Column(
              spacing: 8,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Count: ${viewStore.state.count}"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        viewStore.send(
                          CounterActionEnum.incrementButtonTapped(),
                        );
                      },
                      child: Text("+"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        viewStore.send(
                          CounterActionEnum.decrementButtonTapped(),
                        );
                      },
                      child: Text("-"),
                    ),
                  ],
                ),
                viewStore.state.favorites.value.contains(viewStore.state.count)
                    ? ElevatedButton(
                      onPressed:
                          () => viewStore.send(
                            CounterActionEnum.removeFromFavoritesButtonTapped(), //
                          ),
                      child: Text("Remove from favorites"),
                    )
                    : ElevatedButton(
                      onPressed:
                          () => viewStore.send(
                            CounterActionEnum.addToFavoritesButtonTapped(), //
                          ),
                      child: Text("Add to favorites"),
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}
