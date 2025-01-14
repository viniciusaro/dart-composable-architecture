part of 'effect.dart';

extension FutureEffectWithChecks<Action> on FutureEffect<Action> {
  Future<Action> runWithStateMutationCheck(
    int sealedHash,
    int Function() updatedHash,
  ) {
    final result = run();
    if (sealedHash != updatedHash()) {
      throw InvalidStateMutationError();
    }
    return result.then((value) {
      if (sealedHash != updatedHash()) {
        throw InvalidStateMutationError();
      }
      return value;
    });
  }
}

extension RunEffectWithChecks<Action> on RunEffect<Action> {
  void runWithStateMutationCheck(
    void Function(Action) send,
    int sealedHash,
    int Function() updatedHash,
  ) {
    run(send);
    if (sealedHash != updatedHash()) {
      throw InvalidStateMutationError();
    }
  }
}

extension StreamEffectWithChecks<Action> on StreamEffect<Action> {
  Stream<Action> runWithStateMutationCheck(
    int Function() sealedHash,
    int Function() updatedHash,
  ) {
    final stream = run();
    if (sealedHash() != updatedHash()) {
      throw InvalidStateMutationError();
    }
    return stream.map((action) {
      if (sealedHash() != updatedHash()) {
        throw InvalidStateMutationError();
      }
      return action;
    });
  }
}

final class InvalidStateMutationError extends StateError {
  InvalidStateMutationError()
      : super(
          "state should not be modified inside effect",
        );

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) {
    return other is InvalidStateMutationError;
  }
}
