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
  static final props = KeyPath<AppState, List<Object?>>(
    get: (obj) => obj.props,
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
  static final props = KeyPath<CounterState, List<Object?>>(
    get: (obj) => obj.props,
  );
}

extension FavoritesStatePath on FavoritesState {
  static final favorites = WritableKeyPath<FavoritesState, Set<int>>(
    get: (obj) => obj.favorites,
    set: (obj, favorites) => obj!.copyWith(favorites: favorites),
  );
  static final props = KeyPath<FavoritesState, List<Object?>>(
    get: (obj) => obj.props,
  );
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension AppActionEnum on AppAction {
  static AppAction counter(CounterAction<dynamic, dynamic, dynamic> p) =>
      AppActionCounter(p);
  static AppAction favorites(FavoritesAction<RemoveNumber> p) =>
      AppActionFavorites(p);
}

final class AppActionCounter<
  A extends CounterAction<dynamic, dynamic, dynamic>,
  B extends FavoritesAction<RemoveNumber>
>
    extends AppAction<A, B> {
  final A counter;
  AppActionCounter(this.counter) : super();
}

final class AppActionFavorites<
  A extends CounterAction<dynamic, dynamic, dynamic>,
  B extends FavoritesAction<RemoveNumber>
>
    extends AppAction<A, B> {
  final B favorites;
  AppActionFavorites(this.favorites) : super();
}

extension AppActionPath on AppAction {
  static final counter =
      WritableKeyPath<AppAction, CounterAction<dynamic, dynamic, dynamic>?>(
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
  static final favorites =
      WritableKeyPath<AppAction, FavoritesAction<RemoveNumber>?>(
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
}

final class CounterActionAddToFavoritesButtonTapped<A, B, C>
    extends CounterAction<A, B, C> {
  CounterActionAddToFavoritesButtonTapped() : super();
}

final class CounterActionIncrementButtonTapped<A, B, C>
    extends CounterAction<A, B, C> {
  CounterActionIncrementButtonTapped() : super();
}

final class CounterActionDecrementButtonTapped<A, B, C>
    extends CounterAction<A, B, C> {
  CounterActionDecrementButtonTapped() : super();
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
}

extension FavoritesActionEnum on FavoritesAction {
  static FavoritesAction remove(RemoveNumber p) => FavoritesActionRemove(p);
}

final class FavoritesActionRemove<A extends RemoveNumber>
    extends FavoritesAction<A> {
  final A remove;
  FavoritesActionRemove(this.remove) : super();
}

extension FavoritesActionPath on FavoritesAction {
  static final remove = WritableKeyPath<FavoritesAction, RemoveNumber?>(
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
