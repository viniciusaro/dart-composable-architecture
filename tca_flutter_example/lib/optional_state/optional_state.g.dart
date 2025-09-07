// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'optional_state.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension AppStatePath on AppState {
  static final destination = WritableKeyPath<
    AppState,
    Presents<AppDestination<LoginState, HomeState>>
  >(
    get: (obj) => obj.destination,
    set: (obj, destination) => obj!.copyWith(destination: destination),
  );
}

mixin _$AppState {
  Presents<AppDestination<LoginState, HomeState>> get destination;
  AppState copyWith({
    Presents<AppDestination<LoginState, HomeState>>? destination,
  }) {
    return AppState(destination: destination ?? this.destination);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(destination, other.destination);
  @override
  int get hashCode => Object.hash(runtimeType, destination);
  @override
  String toString() {
    return "AppState(destination: $destination)";
  }
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension AppDestinationEnum on AppDestination {
  static AppDestination login([LoginState? p]) =>
      AppDestinationLogin(p ?? LoginState());
  static AppDestination home([HomeState? p]) =>
      AppDestinationHome(p ?? HomeState());
}

final class AppDestinationLogin<A extends LoginState, B extends HomeState>
    extends AppDestination<A, B> {
  final A login;
  AppDestinationLogin(this.login) : super();

  @override
  int get hashCode => login.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is AppDestinationLogin && other.login == login;

  @override
  String toString() {
    return "AppDestinationLogin.$login";
  }
}

final class AppDestinationHome<A extends LoginState, B extends HomeState>
    extends AppDestination<A, B> {
  final B home;
  AppDestinationHome(this.home) : super();

  @override
  int get hashCode => home.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is AppDestinationHome && other.home == home;

  @override
  String toString() {
    return "AppDestinationHome.$home";
  }
}

extension AppDestinationPath on AppDestination {
  static final login = WritableKeyPath<AppDestination, LoginState?>(
    get: (action) {
      if (action is AppDestinationLogin) {
        return action.login;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = AppDestinationEnum.login(propAction);
      }
      return rootAction!;
    },
  );
  static final home = WritableKeyPath<AppDestination, HomeState?>(
    get: (action) {
      if (action is AppDestinationHome) {
        return action.home;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = AppDestinationEnum.home(propAction);
      }
      return rootAction!;
    },
  );
}

extension AppActionEnum on AppAction {
  static AppAction login(LoginAction<dynamic, dynamic> p) => AppActionLogin(p);
  static AppAction home(HomeAction<dynamic> p) => AppActionHome(p);
}

final class AppActionLogin<
  A extends LoginAction<dynamic, dynamic>,
  B extends HomeAction<dynamic>
>
    extends AppAction<A, B> {
  final A login;
  AppActionLogin(this.login) : super();

  @override
  int get hashCode => login.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is AppActionLogin && other.login == login;

  @override
  String toString() {
    return "AppActionLogin.$login";
  }
}

final class AppActionHome<
  A extends LoginAction<dynamic, dynamic>,
  B extends HomeAction<dynamic>
>
    extends AppAction<A, B> {
  final B home;
  AppActionHome(this.home) : super();

  @override
  int get hashCode => home.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is AppActionHome && other.home == home;

  @override
  String toString() {
    return "AppActionHome.$home";
  }
}

extension AppActionPath on AppAction {
  static final login =
      WritableKeyPath<AppAction, LoginAction<dynamic, dynamic>?>(
        get: (action) {
          if (action is AppActionLogin) {
            return action.login;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = AppActionEnum.login(propAction);
          }
          return rootAction!;
        },
      );
  static final home = WritableKeyPath<AppAction, HomeAction<dynamic>?>(
    get: (action) {
      if (action is AppActionHome) {
        return action.home;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = AppActionEnum.home(propAction);
      }
      return rootAction!;
    },
  );
}
