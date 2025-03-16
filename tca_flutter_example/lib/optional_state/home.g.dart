// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension HomeStatePath on HomeState {}

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
