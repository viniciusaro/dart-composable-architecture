import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

part 'feature_composition.g.dart';

@KeyPathable()
final class AppState extends Equatable {
  CounterState counter = CounterState();
  FavoritesState favorites = FavoritesState();

  @override
  List<Object?> get props => [counter, favorites];
}

@CaseKeyPathable()
sealed class AppAction<
  Counter extends CounterAction,
  Favorites extends FavoritesAction //
> {}

final appReducer = combine([
      pullback(counterReducer, state: AppStatePath.counter, action: AppActionPath.counter),
      pullback(favoritesReducer, state: AppStatePath.favorites, action: AppActionPath.favorites),
    ])
    .onChange(
      of: (state) => state.counter.favorites,
      update: (state, favorites) => state.favorites.favorites = Set.from(favorites),
    )
    .onChange(
      of: (state) => state.favorites.favorites,
      update: (state, favorites) => state.counter.favorites = Set.from(favorites),
    );

@KeyPathable()
final class CounterState extends Equatable {
  int count = 0;
  Set<int> favorites = {};

  @override
  List<Object?> get props => [count, favorites];
}

@CaseKeyPathable()
sealed class CounterAction<
  AddToFavoritesButtonTapped,
  IncrementButtonTapped,
  DecrementButtonTapped,
  RemoveFromFavoritesButtonTapped //
> {}

@KeyPathable()
final class FavoritesState extends Equatable {
  Set<int> favorites = {};

  @override
  List<Object?> get props => [favorites];
}

@CaseKeyPathable()
sealed class FavoritesAction<
  Remove extends int //
> {}

Effect<CounterAction> counterReducer(CounterState state, CounterAction action) {
  switch (action) {
    case CounterActionAddToFavoritesButtonTapped():
      state.favorites.add(state.count);
      return Effect.none();
    case CounterActionIncrementButtonTapped():
      state.count += 1;
      return Effect.none();
    case CounterActionDecrementButtonTapped():
      state.count -= 1;
      return Effect.none();
    case CounterActionRemoveFromFavoritesButtonTapped():
      state.favorites.remove(state.count);
      return Effect.none();
  }
}

Effect<FavoritesAction> favoritesReducer(FavoritesState state, FavoritesAction action) {
  switch (action) {
    case FavoritesActionRemove():
      state.favorites.remove(action.remove);
      return Effect.none();
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
                      onPressed: () => viewStore.send(CounterActionEnum.incrementButtonTapped()),
                      child: Text("+"),
                    ),
                    ElevatedButton(
                      onPressed: () => viewStore.send(CounterActionEnum.decrementButtonTapped()),
                      child: Text("-"),
                    ),
                  ],
                ),
                viewStore.state.favorites.contains(viewStore.state.count)
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

class AppWidget extends StatelessWidget {
  final Store<AppState, AppAction> store;

  const AppWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomNavigationBar: SafeArea(
            child: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.numbers)), //
                Tab(icon: Icon(Icons.favorite)), //
              ],
            ),
          ),
          body: TabBarView(
            children: [
              CounterWidget(
                store: store.view(
                  state: AppStatePath.counter,
                  action: AppActionPath.counter, //
                ),
              ),
              FavoritesWidget(
                store: store.view(
                  state: AppStatePath.favorites,
                  action: AppActionPath.favorites, //
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: AppWidget(store: Store(initialState: AppState(), reducer: debug(appReducer))),
      ),
    ),
  );
}
