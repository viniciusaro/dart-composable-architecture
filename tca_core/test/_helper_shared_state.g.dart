// GENERATED CODE - DO NOT MODIFY BY HAND

part of '_helper_shared_state.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension SharedStatePath on SharedState {
  static final counterA = WritableKeyPath<SharedState, SharedCounterState>(
    get: (obj) => obj.counterA,
    set: (obj, counterA) => obj!.copyWith(counterA: counterA),
  );
  static final counterB = WritableKeyPath<SharedState, SharedCounterState>(
    get: (obj) => obj.counterB,
    set: (obj, counterB) => obj!.copyWith(counterB: counterB),
  );
  static final nonSharedCounter = WritableKeyPath<SharedState, int>(
    get: (obj) => obj.nonSharedCounter,
    set: (obj, nonSharedCounter) =>
        obj!.copyWith(nonSharedCounter: nonSharedCounter),
  );
}

extension SharedCounterStatePath on SharedCounterState {
  static final count = WritableKeyPath<SharedCounterState, Shared<int>>(
    get: (obj) => obj.count,
    set: (obj, count) => obj!.copyWith(count: count),
  );
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension SharedActionEnum on SharedAction {
  static SharedAction counterA(SharedCounterAction<dynamic> p) =>
      SharedActionCounterA(p);
  static SharedAction counterB(SharedCounterAction<dynamic> p) =>
      SharedActionCounterB(p);
  static SharedAction nonSharedCounterIncrement() =>
      SharedActionNonSharedCounterIncrement();
}

final class SharedActionCounterA<A extends SharedCounterAction<dynamic>,
    B extends SharedCounterAction<dynamic>, C> extends SharedAction<A, B, C> {
  final A counterA;
  SharedActionCounterA(this.counterA) : super();

  @override
  int get hashCode => counterA.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is SharedActionCounterA && other.counterA == counterA;

  @override
  String toString() {
    return "SharedActionCounterA.$counterA";
  }
}

final class SharedActionCounterB<A extends SharedCounterAction<dynamic>,
    B extends SharedCounterAction<dynamic>, C> extends SharedAction<A, B, C> {
  final B counterB;
  SharedActionCounterB(this.counterB) : super();

  @override
  int get hashCode => counterB.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is SharedActionCounterB && other.counterB == counterB;

  @override
  String toString() {
    return "SharedActionCounterB.$counterB";
  }
}

final class SharedActionNonSharedCounterIncrement<
    A extends SharedCounterAction<dynamic>,
    B extends SharedCounterAction<dynamic>,
    C> extends SharedAction<A, B, C> {
  SharedActionNonSharedCounterIncrement() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is SharedActionNonSharedCounterIncrement;

  @override
  String toString() {
    return "SharedActionNonSharedCounterIncrement()";
  }
}

extension SharedActionPath on SharedAction {
  static final counterA =
      WritableKeyPath<SharedAction, SharedCounterAction<dynamic>?>(
    get: (action) {
      if (action is SharedActionCounterA) {
        return action.counterA;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = SharedActionEnum.counterA(propAction);
      }
      return rootAction!;
    },
  );
  static final counterB =
      WritableKeyPath<SharedAction, SharedCounterAction<dynamic>?>(
    get: (action) {
      if (action is SharedActionCounterB) {
        return action.counterB;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = SharedActionEnum.counterB(propAction);
      }
      return rootAction!;
    },
  );
  static final nonSharedCounterIncrement =
      WritableKeyPath<SharedAction, SharedActionNonSharedCounterIncrement?>(
    get: (action) {
      if (action is SharedActionNonSharedCounterIncrement) {
        return action;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = SharedActionEnum.nonSharedCounterIncrement();
      }
      return rootAction!;
    },
  );
}

extension SharedCounterActionEnum on SharedCounterAction {
  static SharedCounterAction increment() => SharedCounterActionIncrement();
}

final class SharedCounterActionIncrement<A> extends SharedCounterAction<A> {
  SharedCounterActionIncrement() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) => other is SharedCounterActionIncrement;

  @override
  String toString() {
    return "SharedCounterActionIncrement()";
  }
}

extension SharedCounterActionPath on SharedCounterAction {
  static final increment =
      WritableKeyPath<SharedCounterAction, SharedCounterActionIncrement?>(
    get: (action) {
      if (action is SharedCounterActionIncrement) {
        return action;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = SharedCounterActionEnum.increment();
      }
      return rootAction!;
    },
  );
}
