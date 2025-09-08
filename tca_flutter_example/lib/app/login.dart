import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

part 'login.g.dart';

@KeyPathable()
final class LoginState with _$LoginState {}

@CaseKeyPathable()
sealed class LoginAction {}

final class LoginFeature extends Feature<LoginState, LoginAction> {
  @override
  Reducer<LoginState, LoginAction> build() {
    return Reduce((state, action) {
      switch (action) {
        //
      }
    });
  }
}

final class LoginWidget extends StatelessWidget {
  final Store<LoginState, LoginAction> store;

  const LoginWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return WithViewStore(
      store,
      body: (store) {
        return Placeholder();
      },
    );
  }
}
