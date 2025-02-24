// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reducer_high_order_test.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension RootStatePath on RootState {
  static final counter = WritableKeyPath<RootState, CounterState>(
    get: (obj) => obj.counter,
    set: (obj, counter) => obj!..counter = counter,
  );
  static final favorites = WritableKeyPath<RootState, FavoritesState>(
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

extension RootActionEnum on RootAction {
  static RootAction counter(CounterAction<dynamic, dynamic> p) =>
      RootActionCounter(p);
  static RootAction favorites(
          FavoritesAction<FavoritesAdd, FavoritesRemoveAt> p) =>
      RootActionFavorites(p);
}

final class RootActionCounter<A extends CounterAction<dynamic, dynamic>,
        B extends FavoritesAction<FavoritesAdd, FavoritesRemoveAt>>
    extends RootAction<A, B> {
  final A counter;
  RootActionCounter(this.counter) : super();
}

final class RootActionFavorites<A extends CounterAction<dynamic, dynamic>,
        B extends FavoritesAction<FavoritesAdd, FavoritesRemoveAt>>
    extends RootAction<A, B> {
  final B favorites;
  RootActionFavorites(this.favorites) : super();
}

extension RootActionPath on RootAction {
  static final counter =
      WritableKeyPath<RootAction, CounterAction<dynamic, dynamic>?>(
    get: (action) {
      if (action is RootActionCounter) {
        return action.counter;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = RootActionEnum.counter(propAction);
      }
      return rootAction!;
    },
  );
  static final favorites = WritableKeyPath<RootAction,
      FavoritesAction<FavoritesAdd, FavoritesRemoveAt>?>(
    get: (action) {
      if (action is RootActionFavorites) {
        return action.favorites;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = RootActionEnum.favorites(propAction);
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
  static FavoritesAction add(FavoritesAdd p) => FavoritesActionAdd(p);
  static FavoritesAction removeAt(FavoritesRemoveAt p) =>
      FavoritesActionRemoveAt(p);
}

final class FavoritesActionAdd<A extends FavoritesAdd,
    B extends FavoritesRemoveAt> extends FavoritesAction<A, B> {
  final A add;
  FavoritesActionAdd(this.add) : super();
}

final class FavoritesActionRemoveAt<A extends FavoritesAdd,
    B extends FavoritesRemoveAt> extends FavoritesAction<A, B> {
  final B removeAt;
  FavoritesActionRemoveAt(this.removeAt) : super();
}

extension FavoritesActionPath on FavoritesAction {
  static final add = WritableKeyPath<FavoritesAction, FavoritesAdd?>(
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
  static final removeAt = WritableKeyPath<FavoritesAction, FavoritesRemoveAt?>(
    get: (action) {
      if (action is FavoritesActionRemoveAt) {
        return action.removeAt;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = FavoritesActionEnum.removeAt(propAction);
      }
      return rootAction!;
    },
  );
}
