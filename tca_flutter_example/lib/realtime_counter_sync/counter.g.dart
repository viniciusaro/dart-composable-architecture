// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension CounterStatePath on CounterState {
  static final count = WritableKeyPath<CounterState, int>(
    get: (obj) => obj.count,
    set: (obj, count) => obj!.copyWith(count: count),
  );
}

mixin _$CounterState {
  int get count;
  CounterState copyWith({int? count}) {
    return CounterState(count: count ?? this.count);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CounterState &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(count, other.count);
  @override
  int get hashCode => Object.hash(runtimeType, count);
  @override
  String toString() {
    return "CounterState(count: $count)";
  }
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension CounterActionEnum on CounterAction {
  static CounterAction decrementButtonTapped() =>
      CounterActionDecrementButtonTapped();
  static CounterAction incrementButtonTapped() =>
      CounterActionIncrementButtonTapped();
}

final class CounterActionDecrementButtonTapped<A, B>
    extends CounterAction<A, B> {
  CounterActionDecrementButtonTapped() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) => other is CounterActionDecrementButtonTapped;

  @override
  String toString() {
    return "CounterActionDecrementButtonTapped()";
  }
}

final class CounterActionIncrementButtonTapped<A, B>
    extends CounterAction<A, B> {
  CounterActionIncrementButtonTapped() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) => other is CounterActionIncrementButtonTapped;

  @override
  String toString() {
    return "CounterActionIncrementButtonTapped()";
  }
}

extension CounterActionPath on CounterAction {
  static final decrementButtonTapped =
      WritableKeyPath<CounterAction, CounterActionDecrementButtonTapped?>(
        get: (action) {
          if (action is CounterActionDecrementButtonTapped) {
            return action;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = CounterActionEnum.decrementButtonTapped();
          }
          return rootAction!;
        },
      );
  static final incrementButtonTapped =
      WritableKeyPath<CounterAction, CounterActionIncrementButtonTapped?>(
        get: (action) {
          if (action is CounterActionIncrementButtonTapped) {
            return action;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = CounterActionEnum.incrementButtonTapped();
          }
          return rootAction!;
        },
      );
}
