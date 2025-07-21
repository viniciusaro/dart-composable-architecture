// GENERATED CODE - DO NOT MODIFY BY HAND

part of '_helper_root_state.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension RootStatePath on RootState {
  static final counter = WritableKeyPath<RootState, CounterState>(
    get: (obj) => obj.counter,
    set: (obj, counter) => obj!.copyWith(counter: counter),
  );
  static final favorites = WritableKeyPath<RootState, FavoritesState>(
    get: (obj) => obj.favorites,
    set: (obj, favorites) => obj!.copyWith(favorites: favorites),
  );
}

mixin _$RootState {
  CounterState get counter;
  FavoritesState get favorites;
  RootState copyWith({CounterState? counter, FavoritesState? favorites}) {
    return RootState(
        counter: counter ?? this.counter,
        favorites: favorites ?? this.favorites);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RootState &&
          runtimeType == other.runtimeType &&
          counter == other.counter &&
          favorites == other.favorites;
  @override
  int get hashCode => Object.hash(runtimeType, counter, favorites);
  @override
  String toString() {
    return "RootState(counter: \counter, favorites: \favorites)";
  }
}

extension CounterStatePath on CounterState {
  static final count = WritableKeyPath<CounterState, int>(
    get: (obj) => obj.count,
    set: (obj, count) => obj!.copyWith(count: count),
  );
}

mixin _$CounterState {
  int get count;
  CounterState copyWith({int? count}) {
    return CounterState(count: count ?? this.count);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CounterState &&
          runtimeType == other.runtimeType &&
          count == other.count;
  @override
  int get hashCode => Object.hash(runtimeType, count);
  @override
  String toString() {
    return "CounterState(count: \count)";
  }
}

extension FavoritesStatePath on FavoritesState {
  static final favorites = WritableKeyPath<FavoritesState, List<int>>(
    get: (obj) => obj.favorites,
    set: (obj, favorites) => obj!.copyWith(favorites: favorites),
  );
}

mixin _$FavoritesState {
  List<int> get favorites;
  FavoritesState copyWith({List<int>? favorites}) {
    return FavoritesState(favorites: favorites ?? this.favorites);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoritesState &&
          runtimeType == other.runtimeType &&
          favorites == other.favorites;
  @override
  int get hashCode => Object.hash(runtimeType, favorites);
  @override
  String toString() {
    return "FavoritesState(favorites: \favorites)";
  }
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension RootActionEnum on RootAction {
  static RootAction counter(CounterAction<dynamic, dynamic> p) =>
      RootActionCounter(p);
  static RootAction favorites(FavoritesAction<int, int> p) =>
      RootActionFavorites(p);
}

final class RootActionCounter<A extends CounterAction<dynamic, dynamic>,
    B extends FavoritesAction<int, int>> extends RootAction<A, B> {
  final A counter;
  RootActionCounter(this.counter) : super();

  @override
  int get hashCode => counter.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is RootActionCounter && other.counter == counter;

  @override
  String toString() {
    return "RootActionCounter.$counter";
  }
}

final class RootActionFavorites<A extends CounterAction<dynamic, dynamic>,
    B extends FavoritesAction<int, int>> extends RootAction<A, B> {
  final B favorites;
  RootActionFavorites(this.favorites) : super();

  @override
  int get hashCode => favorites.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is RootActionFavorites && other.favorites == favorites;

  @override
  String toString() {
    return "RootActionFavorites.$favorites";
  }
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
  static final favorites =
      WritableKeyPath<RootAction, FavoritesAction<int, int>?>(
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

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) => other is CounterActionIncrement;

  @override
  String toString() {
    return "CounterActionIncrement()";
  }
}

final class CounterActionDecrement<A, B> extends CounterAction<A, B> {
  CounterActionDecrement() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) => other is CounterActionDecrement;

  @override
  String toString() {
    return "CounterActionDecrement()";
  }
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
  static FavoritesAction add(int p) => FavoritesActionAdd(p);
  static FavoritesAction removeAt(int p) => FavoritesActionRemoveAt(p);
}

final class FavoritesActionAdd<A extends int, B extends int>
    extends FavoritesAction<A, B> {
  final A add;
  FavoritesActionAdd(this.add) : super();

  @override
  int get hashCode => add.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is FavoritesActionAdd && other.add == add;

  @override
  String toString() {
    return "FavoritesActionAdd.$add";
  }
}

final class FavoritesActionRemoveAt<A extends int, B extends int>
    extends FavoritesAction<A, B> {
  final B removeAt;
  FavoritesActionRemoveAt(this.removeAt) : super();

  @override
  int get hashCode => removeAt.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is FavoritesActionRemoveAt && other.removeAt == removeAt;

  @override
  String toString() {
    return "FavoritesActionRemoveAt.$removeAt";
  }
}

extension FavoritesActionPath on FavoritesAction {
  static final add = WritableKeyPath<FavoritesAction, int?>(
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
  static final removeAt = WritableKeyPath<FavoritesAction, int?>(
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
