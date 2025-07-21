// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_composition.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension AppStatePath on AppState {
  static final counter = WritableKeyPath<AppState, CounterState>(
    get: (obj) => obj.counter,
    set: (obj, counter) => obj!.copyWith(counter: counter),
  );
  static final favorites = WritableKeyPath<AppState, FavoritesState>(
    get: (obj) => obj.favorites,
    set: (obj, favorites) => obj!.copyWith(favorites: favorites),
  );
}

mixin _$AppState {
  CounterState get counter;
  FavoritesState get favorites;
  AppState copyWith({CounterState? counter, FavoritesState? favorites}) {
    return AppState(
      counter: counter ?? this.counter,
      favorites: favorites ?? this.favorites,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(counter, other.counter) &&
          const DeepCollectionEquality().equals(favorites, other.favorites);
  @override
  int get hashCode => Object.hash(runtimeType, counter, favorites);
  @override
  String toString() {
    return "AppState(counter: $counter, favorites: $favorites)";
  }
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension AppActionEnum on AppAction {
  static AppAction counter(
    CounterAction<dynamic, dynamic, dynamic, dynamic> p,
  ) => AppActionCounter(p);
  static AppAction favorites(FavoritesAction<int> p) => AppActionFavorites(p);
}

final class AppActionCounter<
  A extends CounterAction<dynamic, dynamic, dynamic, dynamic>,
  B extends FavoritesAction<int>
>
    extends AppAction<A, B> {
  final A counter;
  AppActionCounter(this.counter) : super();

  @override
  int get hashCode => counter.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is AppActionCounter && other.counter == counter;

  @override
  String toString() {
    return "AppActionCounter.$counter";
  }
}

final class AppActionFavorites<
  A extends CounterAction<dynamic, dynamic, dynamic, dynamic>,
  B extends FavoritesAction<int>
>
    extends AppAction<A, B> {
  final B favorites;
  AppActionFavorites(this.favorites) : super();

  @override
  int get hashCode => favorites.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is AppActionFavorites && other.favorites == favorites;

  @override
  String toString() {
    return "AppActionFavorites.$favorites";
  }
}

extension AppActionPath on AppAction {
  static final counter = WritableKeyPath<
    AppAction,
    CounterAction<dynamic, dynamic, dynamic, dynamic>?
  >(
    get: (action) {
      if (action is AppActionCounter) {
        return action.counter;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = AppActionEnum.counter(propAction);
      }
      return rootAction!;
    },
  );
  static final favorites = WritableKeyPath<AppAction, FavoritesAction<int>?>(
    get: (action) {
      if (action is AppActionFavorites) {
        return action.favorites;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = AppActionEnum.favorites(propAction);
      }
      return rootAction!;
    },
  );
}
