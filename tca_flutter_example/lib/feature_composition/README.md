# Example - Feature Composition

This example shows how the Composable Architecture allows composing features in a organized, decoupled and testable way.

The two separate features that will be built are:
- `Counter`: allows the user to count up to a number and add/remove it from the favorites.
- `Favorites`: allows the user to see all favorites in a list and remove them with a swipe gesture.

## States
We start by defining our features domain, more specifically with the state that holds all data needed for the features to work:

```dart
@freezed
@KeyPathable()
abstract class CounterState with _$CounterState {
  const factory CounterState({
    @Default(0) int count,
    @Default({}) Set<int> favorites,
  }) = _CounterState;
}
```

```dart
@freezed
@KeyPathable()
abstract class FavoritesState with _$FavoritesState {
  const factory FavoritesState({
    @Default({}) Set<int> favorites,
  }) = _FavoritesState;
}
```

Notice that both features need a list of favorites to work, since both need to interact with the favorites list. However, they are defined as separate, independent properties on each feature domain.

At least, we need a glue state that will hold on to both features state. In this example we will use a `TabBar` to help us switch between `Counter` and `Favorites` feature, the AppState represents this feature in our hierarchy.

```dart

@freezed
@KeyPathable()
abstract class AppState with _$AppState {
  const factory AppState({
    @Default(CounterState()) CounterState counter,
    @Default(FavoritesState()) FavoritesState favorites,
  }) = _AppState;
}
```

## Actions
Once we have our data defined, we can define actions that will model the user interactions we want.

```dart
@CaseKeyPathable()
sealed class CounterAction<
  AddToFavoritesButtonTapped,
  IncrementButtonTapped,
  DecrementButtonTapped,
  RemoveFromFavoritesButtonTapped
> {}
```

```dart
@CaseKeyPathable()
sealed class FavoritesAction<
  Remove extends int
> {}
```

```dart
@CaseKeyPathable()
sealed class AppAction<
  Counter extends CounterAction,
  Favorites extends FavoritesAction
> {}
```

The `CaseKeyPathable` annotation allows the library to generate child classes for the sealed classes we defined. Those will represent actions that will be processed by the reducers.

## Reducers

Reducer are responsible for mutating the state and returning Effects, where async computation can be executed. In our example, we don't compute any Effects, so we always return `Effect.none()`, while each action is mapped into it's appropriate state mutation. Since we are using sealed classes to model our actions, we can switch over all the possible subclasses, making sure we are taking every action in consideration.

```dart
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
```

```dart
Effect<FavoritesAction> favoritesReducer(Inout<FavoritesState> state, FavoritesAction action) {
  switch (action) {
    case FavoritesActionRemove():
      state.mutate(
        (s) => s.copyWith(favorites: s.favorites.where((e) => e != action.remove).toSet()),
      );
      return Effect.none();
  }
}
```

For the `appReducer` we use special operators that come with the library to allow composing our feature reducers in a global `appReducer` with no need of duplicate code.

```dart
final appReducer = combine([
  pullback(counterReducer, state: AppStatePath.counter, action: AppActionPath.counter),
  pullback(favoritesReducer, state: AppStatePath.favorites, action: AppActionPath.favorites),
])
```

### Synchronizing feature state

Since we do have complete separate states for our features, we need a way to synchronize them when dealing with shared state. In this case, we need to make sure that changes to the `Counter` feature **favorites** are visible to the `Favorites` feature **favorites** and the other way around. To make this happen we make use of another reducer operator called `onChange`:

```dart
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
```

This is the final shape of our `appReducer`.