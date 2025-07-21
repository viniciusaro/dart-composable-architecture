// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension HomeStatePath on HomeState {}

mixin _$HomeState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeState && runtimeType == other.runtimeType;
  @override
  int get hashCode => runtimeType.hashCode;
  @override
  String toString() {
    return "HomeState()";
  }
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension HomeActionEnum on HomeAction {
  static HomeAction onSignOutButtonTapped() =>
      HomeActionOnSignOutButtonTapped();
}

final class HomeActionOnSignOutButtonTapped<A> extends HomeAction<A> {
  HomeActionOnSignOutButtonTapped() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) => other is HomeActionOnSignOutButtonTapped;

  @override
  String toString() {
    return "HomeActionOnSignOutButtonTapped()";
  }
}

extension HomeActionPath on HomeAction {
  static final onSignOutButtonTapped =
      WritableKeyPath<HomeAction, HomeActionOnSignOutButtonTapped?>(
        get: (action) {
          if (action is HomeActionOnSignOutButtonTapped) {
            return action;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = HomeActionEnum.onSignOutButtonTapped();
          }
          return rootAction!;
        },
      );
}
