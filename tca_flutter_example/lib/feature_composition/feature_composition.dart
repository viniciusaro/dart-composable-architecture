import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

part 'feature_composition.freezed.dart';
part 'feature_composition.g.dart';

@freezed
@KeyPathable()
abstract class AppState with _$AppState {
  const factory AppState({
    @Default(CounterState()) CounterState counter,
    @Default(FavoritesState()) FavoritesState favorites,
  }) = _AppState;
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

@freezed
@KeyPathable()
abstract class CounterState with _$CounterState {
  const factory CounterState({
    @Default(0) int count,
    @Default({}) Set<int> favorites, //
  }) = _CounterState;
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
