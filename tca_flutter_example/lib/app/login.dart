import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';

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
