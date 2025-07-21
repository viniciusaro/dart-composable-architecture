// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension LoginStatePath on LoginState {
  static final isLoading = WritableKeyPath<LoginState, bool>(
    get: (obj) => obj.isLoading,
    set: (obj, isLoading) => obj!.copyWith(isLoading: isLoading),
  );
}

mixin _$LoginState {
  bool get isLoading;
  LoginState copyWith({bool? isLoading}) {
    return LoginState(isLoading: isLoading ?? this.isLoading);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginState &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(isLoading, other.isLoading);
  @override
  int get hashCode => Object.hash(runtimeType, isLoading);
  @override
  String toString() {
    return "LoginState(isLoading: $isLoading)";
  }
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension LoginActionEnum on LoginAction {
  static LoginAction onSignInButtonTapped() =>
      LoginActionOnSignInButtonTapped();
  static LoginAction onSignInSucceeded() => LoginActionOnSignInSucceeded();
}

final class LoginActionOnSignInButtonTapped<A, B> extends LoginAction<A, B> {
  LoginActionOnSignInButtonTapped() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) => other is LoginActionOnSignInButtonTapped;

  @override
  String toString() {
    return "LoginActionOnSignInButtonTapped()";
  }
}

final class LoginActionOnSignInSucceeded<A, B> extends LoginAction<A, B> {
  LoginActionOnSignInSucceeded() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) => other is LoginActionOnSignInSucceeded;

  @override
  String toString() {
    return "LoginActionOnSignInSucceeded()";
  }
}

extension LoginActionPath on LoginAction {
  static final onSignInButtonTapped =
      WritableKeyPath<LoginAction, LoginActionOnSignInButtonTapped?>(
        get: (action) {
          if (action is LoginActionOnSignInButtonTapped) {
            return action;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = LoginActionEnum.onSignInButtonTapped();
          }
          return rootAction!;
        },
      );
  static final onSignInSucceeded =
      WritableKeyPath<LoginAction, LoginActionOnSignInSucceeded?>(
        get: (action) {
          if (action is LoginActionOnSignInSucceeded) {
            return action;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = LoginActionEnum.onSignInSucceeded();
          }
          return rootAction!;
        },
      );
}
