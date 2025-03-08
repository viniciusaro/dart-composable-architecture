// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'number_fact.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension NumberFactStatePath on NumberFactState {
  static final count = WritableKeyPath<NumberFactState, int>(
    get: (obj) => obj.count,
    set: (obj, count) => obj!.copyWith(count: count),
  );
  static final isLoading = WritableKeyPath<NumberFactState, bool>(
    get: (obj) => obj.isLoading,
    set: (obj, isLoading) => obj!.copyWith(isLoading: isLoading),
  );
  static final numberFact = WritableKeyPath<NumberFactState, String?>(
    get: (obj) => obj.numberFact,
    set: (obj, numberFact) => obj!.copyWith(numberFact: numberFact),
  );
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension NumberFactActionEnum on NumberFactAction {
  static NumberFactAction decrementButtonTapped() =>
      NumberFactActionDecrementButtonTapped();
  static NumberFactAction incrementButtonTapped() =>
      NumberFactActionIncrementButtonTapped();
  static NumberFactAction numberFactButtonTapped() =>
      NumberFactActionNumberFactButtonTapped();
  static NumberFactAction numberFactResponse(String p) =>
      NumberFactActionNumberFactResponse(p);
}

final class NumberFactActionDecrementButtonTapped<A, B, C, D extends String>
    extends NumberFactAction<A, B, C, D> {
  NumberFactActionDecrementButtonTapped() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is NumberFactActionDecrementButtonTapped;

  @override
  String toString() {
    return "NumberFactActionDecrementButtonTapped()";
  }
}

final class NumberFactActionIncrementButtonTapped<A, B, C, D extends String>
    extends NumberFactAction<A, B, C, D> {
  NumberFactActionIncrementButtonTapped() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is NumberFactActionIncrementButtonTapped;

  @override
  String toString() {
    return "NumberFactActionIncrementButtonTapped()";
  }
}

final class NumberFactActionNumberFactButtonTapped<A, B, C, D extends String>
    extends NumberFactAction<A, B, C, D> {
  NumberFactActionNumberFactButtonTapped() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is NumberFactActionNumberFactButtonTapped;

  @override
  String toString() {
    return "NumberFactActionNumberFactButtonTapped()";
  }
}

final class NumberFactActionNumberFactResponse<A, B, C, D extends String>
    extends NumberFactAction<A, B, C, D> {
  final D numberFactResponse;
  NumberFactActionNumberFactResponse(this.numberFactResponse) : super();

  @override
  int get hashCode => numberFactResponse.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is NumberFactActionNumberFactResponse &&
      other.numberFactResponse == numberFactResponse;

  @override
  String toString() {
    return "NumberFactActionNumberFactResponse.$numberFactResponse";
  }
}

extension NumberFactActionPath on NumberFactAction {
  static final decrementButtonTapped =
      WritableKeyPath<NumberFactAction, NumberFactActionDecrementButtonTapped?>(
        get: (action) {
          if (action is NumberFactActionDecrementButtonTapped) {
            return action;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = NumberFactActionEnum.decrementButtonTapped();
          }
          return rootAction!;
        },
      );
  static final incrementButtonTapped =
      WritableKeyPath<NumberFactAction, NumberFactActionIncrementButtonTapped?>(
        get: (action) {
          if (action is NumberFactActionIncrementButtonTapped) {
            return action;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = NumberFactActionEnum.incrementButtonTapped();
          }
          return rootAction!;
        },
      );
  static final numberFactButtonTapped = WritableKeyPath<
    NumberFactAction,
    NumberFactActionNumberFactButtonTapped?
  >(
    get: (action) {
      if (action is NumberFactActionNumberFactButtonTapped) {
        return action;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = NumberFactActionEnum.numberFactButtonTapped();
      }
      return rootAction!;
    },
  );
  static final numberFactResponse = WritableKeyPath<NumberFactAction, String?>(
    get: (action) {
      if (action is NumberFactActionNumberFactResponse) {
        return action.numberFactResponse;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = NumberFactActionEnum.numberFactResponse(propAction);
      }
      return rootAction!;
    },
  );
}
