import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

@KeyPathable()
final class AppState {
  CounterState counter = CounterState();
  FavoritesState favorites = FavoritesState();

  @override
  String toString() {
    return "AppState: counter: $counter, favorites: $favorites";
  }
}

@CaseKeyPathable()
final class AppAction<
  Counter extends CounterAction,
  Favorites extends FavoritesAction //
> {}

@KeyPathable()
final class CounterState {
  int count = 0;
  Set<int> favorites = {};

  @override
  String toString() {
    return "CounterState: count: $count, favorites: $favorites";
  }
}

@CaseKeyPathable()
final class CounterAction<
  AddToFavoritesButtonTapped,
  IncrementButtonTapped,
  DecrementButtonTapped //
> {}

@KeyPathable()
final class FavoritesState {
  Set<int> favorites = {};
  FavoritesState();

  @override
  String toString() {
    return "FavortiesState: favorites: $favorites";
  }
}

@CaseKeyPathable()
final class FavoritesAction<
  Remove extends RemoveNumber //
> {}

final class RemoveNumber {
  final int number;
  RemoveNumber(this.number);
}

Effect<CounterAction> counterReducer(Inout<CounterState> state, CounterAction action) {
  switch (action) {
    case CounterActionAddToFavoritesButtonTapped():
      state.mutate((s) => s..favorites.add(state.value.count));
      return Effect.none();
    case CounterActionIncrementButtonTapped():
      state.mutate((s) => s..count += 1);
      return Effect.none();
    case CounterActionDecrementButtonTapped():
      state.mutate((s) => s..count -= 1);
      return Effect.none();
  }
  throw Exception("invalid action");
}

Effect<FavoritesAction> favoritesReducer(Inout<FavoritesState> state, FavoritesAction action) {
  switch (action) {
    case FavoritesActionRemove():
      state.mutate((s) => s..favorites.remove(action.remove.number));
      return Effect.none();
  }
  throw Exception("invalid action");
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
                      onPressed: () => viewStore.send(CounterAction.incrementButtonTapped()),
                      child: Text("+"),
                    ),
                    ElevatedButton(
                      onPressed: () => viewStore.send(CounterAction.decrementButtonTapped()),
                      child: Text("-"),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => viewStore.send(CounterAction.addToFavoritesButtonTapped()),
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
                  viewStore.send(FavoritesAction.remove(RemoveNumber(item)));
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
                  state: AppState.counterPath,
                  action: AppAction.counterPath, //
                ),
              ),
              FavoritesWidget(
                store: store.view(
                  state: AppState.favoritesPath,
                  action: AppAction.favoritesPath, //
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
  final appReducer = combine([
        pullback(counterReducer, state: AppState.counterPath, action: AppAction.counterPath),
        pullback(favoritesReducer, state: AppState.favoritesPath, action: AppAction.favoritesPath),
      ])
      .onChange(
        of: (state) => state.counter.favorites,
        update: (state, favorites) => state..favorites.favorites = favorites,
      )
      .onChange(
        of: (state) => state.favorites.favorites,
        update: (state, favorites) => state..counter.favorites = favorites,
      );

  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: AppWidget(store: Store(initialState: AppState(), reducer: debug(appReducer))),
      ),
    ),
  );
}
