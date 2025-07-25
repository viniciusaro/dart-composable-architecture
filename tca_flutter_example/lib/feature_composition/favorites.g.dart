// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension FavoritesStatePath on FavoritesState {
  static final favorites = WritableKeyPath<FavoritesState, Shared<Set<int>>>(
    get: (obj) => obj.favorites,
    set: (obj, favorites) => obj!.copyWith(favorites: favorites),
  );
}

mixin _$FavoritesState {
  Shared<Set<int>> get favorites;
  FavoritesState copyWith({Shared<Set<int>>? favorites}) {
    return FavoritesState(favorites: favorites ?? this.favorites);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoritesState &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(favorites, other.favorites);
  @override
  int get hashCode => Object.hash(runtimeType, favorites);
  @override
  String toString() {
    return "FavoritesState(favorites: $favorites)";
  }
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

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
    return "FavoritesActionRemove.$remove";
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
