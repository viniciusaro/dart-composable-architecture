import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

import 'counter.dart';
import 'favorites.dart';

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
