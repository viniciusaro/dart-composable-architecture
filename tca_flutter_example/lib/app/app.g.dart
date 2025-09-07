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
  static AppDestination home(HomeState p) => AppDestinationHome(p);
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
  static AppAction home(HomeAction<FilesAction> p) => AppActionHome(p);
  static AppAction login(LoginAction p) => AppActionLogin(p);
}

final class AppActionHome<
  A extends HomeAction<FilesAction>,
  B extends LoginAction
>
    extends AppAction<A, B> {
  final A home;
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
  A extends HomeAction<FilesAction>,
  B extends LoginAction
>
    extends AppAction<A, B> {
  final B login;
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
  static final home = WritableKeyPath<AppAction, HomeAction<FilesAction>?>(
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
  static final login = WritableKeyPath<AppAction, LoginAction?>(
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
