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

extension CounterStatePath on CounterState {
  static final count = WritableKeyPath<CounterState, int>(
    get: (obj) => obj.count,
    set: (obj, count) => obj!.copyWith(count: count),
  );
  static final favorites = WritableKeyPath<CounterState, Set<int>>(
    get: (obj) => obj.favorites,
    set: (obj, favorites) => obj!.copyWith(favorites: favorites),
  );
}

extension FavoritesStatePath on FavoritesState {
  static final favorites = WritableKeyPath<FavoritesState, Set<int>>(
    get: (obj) => obj.favorites,
    set: (obj, favorites) => obj!.copyWith(favorites: favorites),
  );
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
    return "AppActionCounter<<A extends CounterAction<dynamic, dynamic, dynamic, dynamic>, B extends FavoritesAction<int>>>(counter: $counter)";
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
    return "AppActionFavorites<<A extends CounterAction<dynamic, dynamic, dynamic, dynamic>, B extends FavoritesAction<int>>>(favorites: $favorites)";
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

extension CounterActionEnum on CounterAction {
  static CounterAction addToFavoritesButtonTapped() =>
      CounterActionAddToFavoritesButtonTapped();
  static CounterAction incrementButtonTapped() =>
      CounterActionIncrementButtonTapped();
  static CounterAction decrementButtonTapped() =>
      CounterActionDecrementButtonTapped();
  static CounterAction removeFromFavoritesButtonTapped() =>
      CounterActionRemoveFromFavoritesButtonTapped();
}

final class CounterActionAddToFavoritesButtonTapped<A, B, C, D>
    extends CounterAction<A, B, C, D> {
  CounterActionAddToFavoritesButtonTapped() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is CounterActionAddToFavoritesButtonTapped;

  @override
  String toString() {
    return "CounterActionAddToFavoritesButtonTapped<<A, B, C, D>>";
  }
}

final class CounterActionIncrementButtonTapped<A, B, C, D>
    extends CounterAction<A, B, C, D> {
  CounterActionIncrementButtonTapped() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) => other is CounterActionIncrementButtonTapped;

  @override
  String toString() {
    return "CounterActionIncrementButtonTapped<<A, B, C, D>>";
  }
}

final class CounterActionDecrementButtonTapped<A, B, C, D>
    extends CounterAction<A, B, C, D> {
  CounterActionDecrementButtonTapped() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) => other is CounterActionDecrementButtonTapped;

  @override
  String toString() {
    return "CounterActionDecrementButtonTapped<<A, B, C, D>>";
  }
}

final class CounterActionRemoveFromFavoritesButtonTapped<A, B, C, D>
    extends CounterAction<A, B, C, D> {
  CounterActionRemoveFromFavoritesButtonTapped() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is CounterActionRemoveFromFavoritesButtonTapped;

  @override
  String toString() {
    return "CounterActionRemoveFromFavoritesButtonTapped<<A, B, C, D>>";
  }
}

extension CounterActionPath on CounterAction {
  static final addToFavoritesButtonTapped =
      WritableKeyPath<CounterAction, CounterActionAddToFavoritesButtonTapped?>(
        get: (action) {
          if (action is CounterActionAddToFavoritesButtonTapped) {
            return action;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = CounterActionEnum.addToFavoritesButtonTapped();
          }
          return rootAction!;
        },
      );
  static final incrementButtonTapped =
      WritableKeyPath<CounterAction, CounterActionIncrementButtonTapped?>(
        get: (action) {
          if (action is CounterActionIncrementButtonTapped) {
            return action;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = CounterActionEnum.incrementButtonTapped();
          }
          return rootAction!;
        },
      );
  static final decrementButtonTapped =
      WritableKeyPath<CounterAction, CounterActionDecrementButtonTapped?>(
        get: (action) {
          if (action is CounterActionDecrementButtonTapped) {
            return action;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = CounterActionEnum.decrementButtonTapped();
          }
          return rootAction!;
        },
      );
  static final removeFromFavoritesButtonTapped = WritableKeyPath<
    CounterAction,
    CounterActionRemoveFromFavoritesButtonTapped?
  >(
    get: (action) {
      if (action is CounterActionRemoveFromFavoritesButtonTapped) {
        return action;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = CounterActionEnum.removeFromFavoritesButtonTapped();
      }
      return rootAction!;
    },
  );
}

extension FavoritesActionEnum on FavoritesAction {
  static FavoritesAction remove(int p) => FavoritesActionRemove(p);
}

final class FavoritesActionRemove<A extends int> extends FavoritesAction<A> {
  final A remove;
  FavoritesActionRemove(this.remove) : super();

  @override
  int get hashCode => remove.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is FavoritesActionRemove && other.remove == remove;

  @override
  String toString() {
    return "FavoritesActionRemove<<A extends int>>(remove: $remove)";
  }
}

extension FavoritesActionPath on FavoritesAction {
  static final remove = WritableKeyPath<FavoritesAction, int?>(
    get: (action) {
      if (action is FavoritesActionRemove) {
        return action.remove;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = FavoritesActionEnum.remove(propAction);
      }
      return rootAction!;
    },
  );
}
