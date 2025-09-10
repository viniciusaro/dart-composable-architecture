// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension AppStatePath on AppState {
  static final destination = WritableKeyPath<
    AppState,
    Presents<AppDestination<HomeState, LoginState>>
  >(
    get: (obj) => obj.destination,
    set: (obj, destination) => obj!.copyWith(destination: destination),
  );
}

mixin _$AppState {
  Presents<AppDestination<HomeState, LoginState>> get destination;
  AppState copyWith({
    Presents<AppDestination<HomeState, LoginState>>? destination,
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
  static AppDestination home([HomeState? p]) =>
      AppDestinationHome(p ?? HomeState());
  static AppDestination login([LoginState? p]) =>
      AppDestinationLogin(p ?? LoginState());
}

final class AppDestinationHome<A extends HomeState, B extends LoginState>
    extends AppDestination<A, B> {
  final A home;
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

final class AppDestinationLogin<A extends HomeState, B extends LoginState>
    extends AppDestination<A, B> {
  final B login;
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

extension AppDestinationPath on AppDestination {
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
}

extension AppActionEnum on AppAction {
  static AppAction onAppStart() => AppActionOnAppStart();
  static AppAction onAuthResult(AppDestination<HomeState, LoginState> p) =>
      AppActionOnAuthResult(p);
  static AppAction home(HomeAction<FilesAction<dynamic>> p) => AppActionHome(p);
  static AppAction login(LoginAction<LoginInfo, User> p) => AppActionLogin(p);
}

final class AppActionOnAppStart<
  A,
  B extends AppDestination<HomeState, LoginState>,
  C extends HomeAction<FilesAction<dynamic>>,
  D extends LoginAction<LoginInfo, User>
>
    extends AppAction<A, B, C, D> {
  AppActionOnAppStart() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) => other is AppActionOnAppStart;

  @override
  String toString() {
    return "AppActionOnAppStart()";
  }
}

final class AppActionOnAuthResult<
  A,
  B extends AppDestination<HomeState, LoginState>,
  C extends HomeAction<FilesAction<dynamic>>,
  D extends LoginAction<LoginInfo, User>
>
    extends AppAction<A, B, C, D> {
  final B onAuthResult;
  AppActionOnAuthResult(this.onAuthResult) : super();

  @override
  int get hashCode => onAuthResult.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is AppActionOnAuthResult && other.onAuthResult == onAuthResult;

  @override
  String toString() {
    return "AppActionOnAuthResult.$onAuthResult";
  }
}

final class AppActionHome<
  A,
  B extends AppDestination<HomeState, LoginState>,
  C extends HomeAction<FilesAction<dynamic>>,
  D extends LoginAction<LoginInfo, User>
>
    extends AppAction<A, B, C, D> {
  final C home;
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

final class AppActionLogin<
  A,
  B extends AppDestination<HomeState, LoginState>,
  C extends HomeAction<FilesAction<dynamic>>,
  D extends LoginAction<LoginInfo, User>
>
    extends AppAction<A, B, C, D> {
  final D login;
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

extension AppActionPath on AppAction {
  static final onAppStart = WritableKeyPath<AppAction, AppActionOnAppStart?>(
    get: (action) {
      if (action is AppActionOnAppStart) {
        return action;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = AppActionEnum.onAppStart();
      }
      return rootAction!;
    },
  );
  static final onAuthResult =
      WritableKeyPath<AppAction, AppDestination<HomeState, LoginState>?>(
        get: (action) {
          if (action is AppActionOnAuthResult) {
            return action.onAuthResult;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = AppActionEnum.onAuthResult(propAction);
          }
          return rootAction!;
        },
      );
  static final home =
      WritableKeyPath<AppAction, HomeAction<FilesAction<dynamic>>?>(
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
  static final login =
      WritableKeyPath<AppAction, LoginAction<LoginInfo, User>?>(
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
}
