// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension LoginStatePath on LoginState {}

mixin _$LoginState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginState && runtimeType == other.runtimeType;
  @override
  int get hashCode => runtimeType.hashCode;
  @override
  String toString() {
    return "LoginState()";
  }
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension LoginActionEnum on LoginAction {
  static LoginAction onLoginButtonTapped(LoginInfo p) =>
      LoginActionOnLoginButtonTapped(p);
  static LoginAction onLoggedIn(User p) => LoginActionOnLoggedIn(p);
}

final class LoginActionOnLoginButtonTapped<A extends LoginInfo, B extends User>
    extends LoginAction<A, B> {
  final A onLoginButtonTapped;
  LoginActionOnLoginButtonTapped(this.onLoginButtonTapped) : super();

  @override
  int get hashCode => onLoginButtonTapped.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is LoginActionOnLoginButtonTapped &&
      other.onLoginButtonTapped == onLoginButtonTapped;

  @override
  String toString() {
    return "LoginActionOnLoginButtonTapped.$onLoginButtonTapped";
  }
}

final class LoginActionOnLoggedIn<A extends LoginInfo, B extends User>
    extends LoginAction<A, B> {
  final B onLoggedIn;
  LoginActionOnLoggedIn(this.onLoggedIn) : super();

  @override
  int get hashCode => onLoggedIn.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is LoginActionOnLoggedIn && other.onLoggedIn == onLoggedIn;

  @override
  String toString() {
    return "LoginActionOnLoggedIn.$onLoggedIn";
  }
}

extension LoginActionPath on LoginAction {
  static final onLoginButtonTapped = WritableKeyPath<LoginAction, LoginInfo?>(
    get: (action) {
      if (action is LoginActionOnLoginButtonTapped) {
        return action.onLoginButtonTapped;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = LoginActionEnum.onLoginButtonTapped(propAction);
      }
      return rootAction!;
    },
  );
  static final onLoggedIn = WritableKeyPath<LoginAction, User?>(
    get: (action) {
      if (action is LoginActionOnLoggedIn) {
        return action.onLoggedIn;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = LoginActionEnum.onLoggedIn(propAction);
      }
      return rootAction!;
    },
  );
}
