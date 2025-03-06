import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

part 'feature_composition.g.dart';

@KeyPathable()
final class AppState extends Equatable {
  final CounterState counter;
  final FavoritesState favorites;

  const AppState({
    this.counter = const CounterState(),
    this.favorites = const FavoritesState(), //
  });

  AppState copyWith({CounterState? counter, FavoritesState? favorites}) {
    return AppState(counter: counter ?? this.counter, favorites: favorites ?? this.favorites);
  }

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
      update: (state, favorites) {
        state.mutate((s) => s.copyWith(favorites: s.favorites.copyWith(favorites: favorites)));
      },
    )
    .onChange(
      of: (state) => state.favorites.favorites,
      update: (state, favorites) {
        state.mutate((s) => s.copyWith(counter: s.counter.copyWith(favorites: favorites)));
      },
    );

@KeyPathable()
final class CounterState extends Equatable {
  final int count;
  final Set<int> favorites;

  const CounterState({this.count = 0, this.favorites = const {}});

  CounterState copyWith({int? count, Set<int>? favorites}) {
    return CounterState(
      count: count ?? this.count,
      favorites: favorites ?? this.favorites, //
    );
  }

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

Effect<CounterAction> counterReducer(Inout<CounterState> state, CounterAction action) {
  switch (action) {
    case CounterActionAddToFavoritesButtonTapped():
      state.mutate((s) => s.copyWith(favorites: {...s.favorites, s.count}));
      return Effect.none();
    case CounterActionIncrementButtonTapped():
      state.mutate((s) => s.copyWith(count: s.count + 1));
      return Effect.none();
    case CounterActionDecrementButtonTapped():
      state.mutate((s) => s.copyWith(count: s.count - 1));
      return Effect.none();
    case CounterActionRemoveFromFavoritesButtonTapped():
      state.mutate((s) => s.copyWith(favorites: s.favorites.where((c) => c != s.count).toSet()));
      return Effect.none();
  }
}

@KeyPathable()
final class FavoritesState extends Equatable {
  final Set<int> favorites;
  const FavoritesState({this.favorites = const {}});

  FavoritesState copyWith({Set<int>? favorites}) {
    return FavoritesState(favorites: favorites ?? this.favorites);
  }

  @override
  List<Object?> get props => [favorites];
}

@CaseKeyPathable()
sealed class FavoritesAction<
  Remove extends int //
> {}

Effect<FavoritesAction> favoritesReducer(Inout<FavoritesState> state, FavoritesAction action) {
  switch (action) {
    case FavoritesActionRemove():
      state.mutate((s) {
        final favorites = s.favorites.where((e) => e != action.remove);
        return s.copyWith(favorites: Set.from(favorites));
      });
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
