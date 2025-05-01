// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instrumentation.dart';

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension CounterActionEnum on CounterAction {
  static CounterAction incrementButtonTapped() =>
      CounterActionIncrementButtonTapped();
}

final class CounterActionIncrementButtonTapped<A> extends CounterAction<A> {
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
