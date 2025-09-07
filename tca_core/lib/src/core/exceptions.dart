part of 'store.dart';

final class EffectfullStateMutation implements Exception {
  @override
  String toString() {
    return "EffectfullStateMutation: State mutation detected outside reducer";
  }

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) {
    return other is EffectfullStateMutation;
  }
}

final class MutationOfSameInstance implements Exception {
  @override
  String toString() {
    return "MutationOfSameInstance: Mutation on same instance is not allowed. Reducers should make a copy of their state when mutation is needed";
  }

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) {
    return other is MutationOfSameInstance;
  }
}

final class ExpectedIsSameInstance implements Exception {
  @override
  String toString() {
    return "ExpectedIsSameInstance: Same instance is not allowed to be returned on TestStore.send";
  }

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) {
    return other is ExpectedIsSameInstance;
  }
}

final class UnexpectedChanges implements Exception {
  final dynamic action;
  final dynamic expected;
  final dynamic updated;

  UnexpectedChanges(
      {required this.action, required this.expected, required this.updated});

  @override
  String toString() {
    final actionString = action;
    final expectedString = expected;
    final updatedString = updated;

    return """UnexpectedChanges: Detected unexpected changes. 
Action:
  $actionString,
Expected:
  $expectedString,
Got: 
  $updatedString""";
  }

  @override
  int get hashCode =>
      expected.hashCode ^ updated.hashCode ^ runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) {
    return other is UnexpectedChanges &&
        other.expected == expected &&
        other.updated == updated;
  }
}

final class UnexpectedAction implements Exception {
  final dynamic action;

  UnexpectedAction({required this.action});

  @override
  String toString() {
    return "UnexpectedAction: Received unexpected action: $action";
  }

  @override
  int get hashCode => action.hashCode ^ runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) {
    return other is UnexpectedAction && other.action == action;
  }
}

final class UnexpectedPendingActions implements Exception {
  final dynamic pendingActions;

  UnexpectedPendingActions({required this.pendingActions});

  @override
  String toString() {
    return "UnexpectedPendingActions: Found unexpected pending actions: $pendingActions";
  }

  @override
  int get hashCode => pendingActions.hashCode ^ runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) {
    return other is UnexpectedPendingActions &&
        other.pendingActions == pendingActions;
  }
}
