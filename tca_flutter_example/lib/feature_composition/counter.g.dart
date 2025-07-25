// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension CounterStatePath on CounterState {
  static final count = WritableKeyPath<CounterState, int>(
    get: (obj) => obj.count,
    set: (obj, count) => obj!.copyWith(count: count),
  );
  static final favorites = WritableKeyPath<CounterState, Shared<Set<int>>>(
    get: (obj) => obj.favorites,
    set: (obj, favorites) => obj!.copyWith(favorites: favorites),
  );
}

mixin _$CounterState {
  int get count;
  Shared<Set<int>> get favorites;
  CounterState copyWith({int? count, Shared<Set<int>>? favorites}) {
    return CounterState(
      count: count ?? this.count,
      favorites: favorites ?? this.favorites,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CounterState &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(count, other.count) &&
          const DeepCollectionEquality().equals(favorites, other.favorites);
  @override
  int get hashCode => Object.hash(runtimeType, count, favorites);
  @override
  String toString() {
    return "CounterState(count: $count, favorites: $favorites)";
  }
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

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
    return "CounterActionAddToFavoritesButtonTapped()";
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
    return "CounterActionIncrementButtonTapped()";
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
    return "CounterActionDecrementButtonTapped()";
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
    return "CounterActionRemoveFromFavoritesButtonTapped()";
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
