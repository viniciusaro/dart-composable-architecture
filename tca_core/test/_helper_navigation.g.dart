// GENERATED CODE - DO NOT MODIFY BY HAND

part of '_helper_navigation.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension RootStatePath on RootState {
  static final app = WritableKeyPath<RootState, AppState>(
    get: (obj) => obj.app,
    set: (obj, app) => obj!.copyWith(app: app),
  );
}

extension AppStatePath on AppState {
  static final destination =
      WritableKeyPath<AppState, Presents<AppDestination<DetailState>?>>(
    get: (obj) => obj.destination,
    set: (obj, destination) => obj!.copyWith(destination: destination),
  );
}

mixin _$AppState {
  Presents<AppDestination<DetailState>?> get destination;
  AppState copyWith({Presents<AppDestination<DetailState>?>? destination}) {
    return AppState(destination: destination ?? this.destination);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          destination == other.destination;
  @override
  int get hashCode => Object.hash(runtimeType, destination);
  @override
  String toString() {
    return "AppState(destination: \destination)";
  }
}

extension DetailStatePath on DetailState {}

mixin _$DetailState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailState && runtimeType == other.runtimeType;
  @override
  int get hashCode => runtimeType.hashCode;
  @override
  String toString() {
    return "DetailState()";
  }
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension RootActionEnum on RootAction {
  static RootAction app(AppAction<dynamic, DetailAction> p) => RootActionApp(p);
}

final class RootActionApp<A extends AppAction<dynamic, DetailAction>>
    extends RootAction<A> {
  final A app;
  RootActionApp(this.app) : super();

  @override
  int get hashCode => app.hashCode ^ 31;

  @override
  bool operator ==(Object other) => other is RootActionApp && other.app == app;

  @override
  String toString() {
    return "RootActionApp.$app";
  }
}

extension RootActionPath on RootAction {
  static final app =
      WritableKeyPath<RootAction, AppAction<dynamic, DetailAction>?>(
    get: (action) {
      if (action is RootActionApp) {
        return action.app;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = RootActionEnum.app(propAction);
      }
      return rootAction!;
    },
  );
}

extension AppDestinationEnum on AppDestination {
  static AppDestination detail(DetailState p) => AppDestinationDetail(p);
}

final class AppDestinationDetail<A extends DetailState>
    extends AppDestination<A> {
  final A detail;
  AppDestinationDetail(this.detail) : super();

  @override
  int get hashCode => detail.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is AppDestinationDetail && other.detail == detail;

  @override
  String toString() {
    return "AppDestinationDetail.$detail";
  }
}

extension AppDestinationPath on AppDestination {
  static final detail = WritableKeyPath<AppDestination, DetailState?>(
    get: (action) {
      if (action is AppDestinationDetail) {
        return action.detail;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = AppDestinationEnum.detail(propAction);
      }
      return rootAction!;
    },
  );
}

extension AppActionEnum on AppAction {
  static AppAction onDetailButtonTapped() => AppActionOnDetailButtonTapped();
  static AppAction detail(DetailAction p) => AppActionDetail(p);
}

final class AppActionOnDetailButtonTapped<A, B extends DetailAction>
    extends AppAction<A, B> {
  AppActionOnDetailButtonTapped() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) => other is AppActionOnDetailButtonTapped;

  @override
  String toString() {
    return "AppActionOnDetailButtonTapped()";
  }
}

final class AppActionDetail<A, B extends DetailAction> extends AppAction<A, B> {
  final B detail;
  AppActionDetail(this.detail) : super();

  @override
  int get hashCode => detail.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is AppActionDetail && other.detail == detail;

  @override
  String toString() {
    return "AppActionDetail.$detail";
  }
}

extension AppActionPath on AppAction {
  static final onDetailButtonTapped =
      WritableKeyPath<AppAction, AppActionOnDetailButtonTapped?>(
    get: (action) {
      if (action is AppActionOnDetailButtonTapped) {
        return action;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = AppActionEnum.onDetailButtonTapped();
      }
      return rootAction!;
    },
  );
  static final detail = WritableKeyPath<AppAction, DetailAction?>(
    get: (action) {
      if (action is AppActionDetail) {
        return action.detail;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = AppActionEnum.detail(propAction);
      }
      return rootAction!;
    },
  );
}

extension DetailActionEnum on DetailAction {}

extension DetailActionPath on DetailAction {}
