import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

part 'login.freezed.dart';
part 'login.g.dart';

@freezed
@KeyPathable()
final class LoginState with _$LoginState {
  @override
  final bool isLoading;
  const LoginState({this.isLoading = false});
}

@CaseKeyPathable()
sealed class LoginAction<
  OnSignInButtonTapped,
  OnSignInSucceeded //
> {}

Effect<LoginAction> loginReducer(Inout<LoginState> state, LoginAction action) {
  switch (action) {
    case LoginActionOnSignInButtonTapped():
      state.mutate((s) => s.copyWith(isLoading: true));
      return Effect.future(() async {
        await Future.delayed(const Duration(seconds: 1));
        return LoginActionEnum.onSignInSucceeded();
      });
    case LoginActionOnSignInSucceeded():
      state.mutate((s) => s.copyWith(isLoading: false));
      return Effect.none();
  }
}

class LoginWidget extends StatelessWidget {
  final Store<LoginState, LoginAction> store;

  const LoginWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: WithViewStore(
        store,
        body: (viewStore) {
          return Center(
            child:
                viewStore.state.isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                      onPressed: () => viewStore.send(LoginActionEnum.onSignInButtonTapped()),
                      child: Text("Sign in"),
                    ),
          );
        },
      ),
    );
  }
}
