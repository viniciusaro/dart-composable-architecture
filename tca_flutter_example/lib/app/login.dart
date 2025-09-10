import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

import 'clients/auth_client.dart';
import 'clients/models/models.dart';

part 'login.g.dart';

@KeyPathable()
final class LoginState with _$LoginState {}

class LoginInfo {
  final String username;
  final String password;

  LoginInfo({required this.username, required this.password});
}

@CaseKeyPathable()
sealed class LoginAction<
  OnLoginButtonTapped extends LoginInfo, //
  OnLoggedIn extends User
> {}

final class LoginFeature extends Feature<LoginState, LoginAction> {
  @override
  Reducer<LoginState, LoginAction> build() {
    return Reduce((state, action) {
      switch (action) {
        case LoginActionOnLoginButtonTapped():
          return Effect.future(() async {
            final result = await authClient.login(
              action.onLoginButtonTapped.username,
              action.onLoginButtonTapped.password,
            );
            return LoginActionEnum.onLoggedIn(result);
          });
        case LoginActionOnLoggedIn():
          return Effect.none();
      }
    });
  }
}

final class LoginWidget extends StatelessWidget {
  final Store<LoginState, LoginAction> store;

  const LoginWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WithViewStore(
        store,
        body: (viewStore) {
          return Center(
            child: ElevatedButton(
              onPressed: () {
                viewStore.send(
                  LoginActionEnum.onLoginButtonTapped(
                    LoginInfo(username: "username", password: "password"),
                  ),
                );
              },
              child: Text("Entrar"),
            ),
          );
        },
      ),
    );
  }
}
