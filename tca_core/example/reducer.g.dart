// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reducer.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension AppStatePath on AppState {
  static final counter = WritableKeyPath<AppState, CounterState>(
    get: (obj) => obj.counter,
    set: (obj, counter) => obj!..counter = counter,
  );
  static final favorites = WritableKeyPath<AppState, FavoritesState>(
    get: (obj) => obj.favorites,
    set: (obj, favorites) => obj!..favorites = favorites,
  );
}

extension CounterStatePath on CounterState {
  static final count = WritableKeyPath<CounterState, int>(
    get: (obj) => obj.count,
    set: (obj, count) => obj!..count = count,
  );
}

extension FavoritesStatePath on FavoritesState {
  static final favorites = WritableKeyPath<FavoritesState, List<int>>(
    get: (obj) => obj.favorites,
    set: (obj, favorites) => obj!..favorites = favorites,
  );
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension AppActionEnum on AppAction {
  static AppAction onViewAppear() => AppActionOnViewAppear();
  static AppAction counter(CounterAction<dynamic, dynamic> p) =>
      AppActionCounter(p);
  static AppAction favorites(
          FavoritesAction<AddToFavorites, RemoveFromFavorites> p) =>
      AppActionFavorites(p);
}

final class AppActionOnViewAppear<A, B extends CounterAction<dynamic, dynamic>,
        C extends FavoritesAction<AddToFavorites, RemoveFromFavorites>>
    extends AppAction<A, B, C> {
  AppActionOnViewAppear() : super();
}

final class AppActionCounter<A, B extends CounterAction<dynamic, dynamic>,
        C extends FavoritesAction<AddToFavorites, RemoveFromFavorites>>
    extends AppAction<A, B, C> {
  final B counter;
  AppActionCounter(this.counter) : super();
}

final class AppActionFavorites<A, B extends CounterAction<dynamic, dynamic>,
        C extends FavoritesAction<AddToFavorites, RemoveFromFavorites>>
    extends AppAction<A, B, C> {
  final C favorites;
  AppActionFavorites(this.favorites) : super();
}

extension AppActionPath on AppAction {
  static final onViewAppear =
      WritableKeyPath<AppAction, AppActionOnViewAppear?>(
    get: (action) {
      if (action is AppActionOnViewAppear) {
        return action;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = AppActionEnum.onViewAppear();
      }
      return rootAction!;
    },
  );
  static final counter =
      WritableKeyPath<AppAction, CounterAction<dynamic, dynamic>?>(
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
  static final favorites = WritableKeyPath<AppAction,
      FavoritesAction<AddToFavorites, RemoveFromFavorites>?>(
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
  static CounterAction increment() => CounterActionIncrement();
  static CounterAction decrement() => CounterActionDecrement();
}

final class CounterActionIncrement<A, B> extends CounterAction<A, B> {
  CounterActionIncrement() : super();
}

final class CounterActionDecrement<A, B> extends CounterAction<A, B> {
  CounterActionDecrement() : super();
}

extension CounterActionPath on CounterAction {
  static final increment =
      WritableKeyPath<CounterAction, CounterActionIncrement?>(
    get: (action) {
      if (action is CounterActionIncrement) {
        return action;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = CounterActionEnum.increment();
      }
      return rootAction!;
    },
  );
  static final decrement =
      WritableKeyPath<CounterAction, CounterActionDecrement?>(
    get: (action) {
      if (action is CounterActionDecrement) {
        return action;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = CounterActionEnum.decrement();
      }
      return rootAction!;
    },
  );
}

extension FavoritesActionEnum on FavoritesAction {
  static FavoritesAction add(AddToFavorites p) => FavoritesActionAdd(p);
  static FavoritesAction remove(RemoveFromFavorites p) =>
      FavoritesActionRemove(p);
}

final class FavoritesActionAdd<A extends AddToFavorites,
    B extends RemoveFromFavorites> extends FavoritesAction<A, B> {
  final A add;
  FavoritesActionAdd(this.add) : super();
}

final class FavoritesActionRemove<A extends AddToFavorites,
    B extends RemoveFromFavorites> extends FavoritesAction<A, B> {
  final B remove;
  FavoritesActionRemove(this.remove) : super();
}

extension FavoritesActionPath on FavoritesAction {
  static final add = WritableKeyPath<FavoritesAction, AddToFavorites?>(
    get: (action) {
      if (action is FavoritesActionAdd) {
        return action.add;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = FavoritesActionEnum.add(propAction);
      }
      return rootAction!;
    },
  );
  static final remove = WritableKeyPath<FavoritesAction, RemoveFromFavorites?>(
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
