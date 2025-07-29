# Example - Feature Composition

This example demonstrates how the Composable Architecture enables composing features in an organized, decoupled, and testable way.

The two separate features that will be built are:
- `Counter`: Allows the user to count up to a number and add/remove it from favorites.
- `Favorites`: Displays a list of favorite numbers and allows removal via a swipe gesture.

https://github.com/user-attachments/assets/073e4014-bd97-4fbc-a02d-dc33d9bf668f

## States
We begin by defining our feature domains, specifically the state that holds all the necessary data for each feature:

```dart
@KeyPathable()
class CounterState with _$CounterState {
  @override
  final int count;

  @override
  final Shared<Set<int>> favorites;

  CounterState({this.count = 0, Shared<Set<int>>? favorites})
    : favorites = favorites ?? Shared(InMemorySource({}));
}
```

```dart
@KeyPathable()
class FavoritesState with _$FavoritesState {
  @override
  final Shared<Set<int>> favorites;

  FavoritesState({Shared<Set<int>>? favorites})
    : favorites = favorites ?? Shared(InMemorySource({}));
}
```

Both features require access to a list of favorites since they interact with it. However, they each define their own independent properties for favorites within their respective domains. They are wrapped in the special `Shared` type that comes with the library. This type allows automatic synchronization between the values in the features.

Finally, we need a state to encapsulate both feature states. In this example, we use a TabBar to switch between the Counter and Favorites features, and AppState serves as the root state in our domain hierarchy:

```dart
@KeyPathable()
class AppState with _$AppState {
  @override
  final CounterState counter;

  @override
  final FavoritesState favorites;

  AppState({
    CounterState? counter,
    FavoritesState? favorites, //
  }) : counter = counter ?? CounterState(),
       favorites = favorites ?? FavoritesState();
}
```

## Actions
With our data defined, we can now define actions to model user interactions:

```dart
@CaseKeyPathable()
sealed class CounterAction<
  AddToFavoritesButtonTapped,
  IncrementButtonTapped,
  DecrementButtonTapped,
  RemoveFromFavoritesButtonTapped //
> {}
```

```dart
@CaseKeyPathable()
sealed class FavoritesAction<
  Remove extends int //
> {}
```

```dart
@CaseKeyPathable()
sealed class AppAction<
  Counter extends CounterAction,
  Favorites extends FavoritesAction //
> {}
```

The `@CaseKeyPathable` annotation enables the library to generate child classes for our sealed classes. These subclasses represent actions that will be processed by reducers.

## Reducers and Features

Reducers are responsible for mutating the state and returning Effects, which can handle asynchronous computations. They should be implemented in types called `Features`. In this example, we do not perform any asynchronous computations, so we always return Effect.none(). Each action is mapped to its respective state mutation. Since we use sealed classes to model actions, we can switch over all possible subclasses, ensuring all actions are properly handled.

```dart
final class CounterFeature extends Feature<CounterState, CounterAction> {
  @override
  Reducer<CounterState, CounterAction> build() {
    return Reduce((state, action) {
      switch (action) {
        case CounterActionIncrementButtonTapped():
          state.mutate((s) => s.copyWith(count: s.count + 1));
          return Effect.none();
        case CounterActionDecrementButtonTapped():
          state.mutate((s) => s.copyWith(count: s.count - 1));
          return Effect.none();
        case CounterActionAddToFavoritesButtonTapped():
          state.mutate(
            (s) => s.copyWith(
              favorites: s.favorites.set((curr) => {...curr, s.count}),
            ),
          );
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
```

```dart
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
```

Features are analogous to application logic, just as Widgets are to UI logic. This is why they also have a build method, allowing them to be transformed and composed in various ways to create an app.

For the AppFeature, we use special operators from the library to compose our feature reducers into a global reducer without duplicating code:

```dart
final class AppFeature extends Feature<AppState, AppAction> {
  @override
  Reducer<AppState, AppAction> build() {
    return Reduce.combine([
      Scope(
        state: AppStatePath.counter,
        action: AppActionPath.counter,
        reducer: CounterFeature(),
      ),
      Scope(
        state: AppStatePath.favorites,
        action: AppActionPath.favorites,
        reducer: FavoritesFeature(),
      ),
    ]);
  }
}
```

`AppStatePath.counter`, `AppActionPath.counter`, `AppStatePath.favorites` and `AppActionPath.favorites` are generated by the `@KeyPathable` and `@CaseKeyPathable` annotations. More about that on `key_paths`.


