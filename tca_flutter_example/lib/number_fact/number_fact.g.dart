// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'number_fact.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension FeatureStatePath on FeatureState {
  static final count = WritableKeyPath<FeatureState, int>(
    get: (obj) => obj.count,
    set: (obj, count) => obj!..count = count,
  );
  static final isLoading = WritableKeyPath<FeatureState, bool>(
    get: (obj) => obj.isLoading,
    set: (obj, isLoading) => obj!..isLoading = isLoading,
  );
  static final numberFact = WritableKeyPath<FeatureState, String?>(
    get: (obj) => obj.numberFact,
    set: (obj, numberFact) => obj!..numberFact = numberFact,
  );
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension FeatureActionEnum on FeatureAction {
  static FeatureAction decrementButtonTapped() =>
      FeatureActionDecrementButtonTapped();
  static FeatureAction incrementButtonTapped() =>
      FeatureActionIncrementButtonTapped();
  static FeatureAction numberFactButtonTapped() =>
      FeatureActionNumberFactButtonTapped();
  static FeatureAction numberFactResponse(NumberFactResponseValue p) =>
      FeatureActionNumberFactResponse(p);
}

final class FeatureActionDecrementButtonTapped<
  A,
  B,
  C,
  D extends NumberFactResponseValue
>
    extends FeatureAction<A, B, C, D> {
  FeatureActionDecrementButtonTapped() : super();
}

final class FeatureActionIncrementButtonTapped<
  A,
  B,
  C,
  D extends NumberFactResponseValue
>
    extends FeatureAction<A, B, C, D> {
  FeatureActionIncrementButtonTapped() : super();
}

final class FeatureActionNumberFactButtonTapped<
  A,
  B,
  C,
  D extends NumberFactResponseValue
>
    extends FeatureAction<A, B, C, D> {
  FeatureActionNumberFactButtonTapped() : super();
}

final class FeatureActionNumberFactResponse<
  A,
  B,
  C,
  D extends NumberFactResponseValue
>
    extends FeatureAction<A, B, C, D> {
  final D numberFactResponse;
  FeatureActionNumberFactResponse(this.numberFactResponse) : super();
}

extension FeatureActionPath on FeatureAction {
  static final decrementButtonTapped =
      WritableKeyPath<FeatureAction, FeatureActionDecrementButtonTapped?>(
        get: (action) {
          if (action is FeatureActionDecrementButtonTapped) {
            return action;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = FeatureActionEnum.decrementButtonTapped();
          }
          return rootAction!;
        },
      );
  static final incrementButtonTapped =
      WritableKeyPath<FeatureAction, FeatureActionIncrementButtonTapped?>(
        get: (action) {
          if (action is FeatureActionIncrementButtonTapped) {
            return action;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = FeatureActionEnum.incrementButtonTapped();
          }
          return rootAction!;
        },
      );
  static final numberFactButtonTapped =
      WritableKeyPath<FeatureAction, FeatureActionNumberFactButtonTapped?>(
        get: (action) {
          if (action is FeatureActionNumberFactButtonTapped) {
            return action;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = FeatureActionEnum.numberFactButtonTapped();
          }
          return rootAction!;
        },
      );
  static final numberFactResponse =
      WritableKeyPath<FeatureAction, NumberFactResponseValue?>(
        get: (action) {
          if (action is FeatureActionNumberFactResponse) {
            return action.numberFactResponse;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = FeatureActionEnum.numberFactResponse(propAction);
          }
          return rootAction!;
        },
      );
}
