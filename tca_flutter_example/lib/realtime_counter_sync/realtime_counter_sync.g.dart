// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_counter_sync.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension AppStatePath on AppState {
  static final counter = WritableKeyPath<AppState, CounterState>(
    get: (obj) => obj.counter,
    set: (obj, counter) => obj!.copyWith(counter: counter),
  );
}

extension CounterStatePath on CounterState {
  static final count = WritableKeyPath<CounterState, int>(
    get: (obj) => obj.count,
    set: (obj, count) => obj!.copyWith(count: count),
  );
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension AppActionEnum on AppAction {
  static AppAction counter(CounterAction<dynamic, dynamic> p) =>
      AppActionCounter(p);
  static AppAction messageBroker(MessageBrokerAction<dynamic, dynamic> p) =>
      AppActionMessageBroker(p);
  static AppAction onInitState() => AppActionOnInitState();
}

final class AppActionCounter<
  A extends CounterAction<dynamic, dynamic>,
  B extends MessageBrokerAction<dynamic, dynamic>,
  C
>
    extends AppAction<A, B, C> {
  final A counter;
  AppActionCounter(this.counter) : super();

  @override
  int get hashCode => counter.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is AppActionCounter && other.counter == counter;

  @override
  String toString() {
    return "AppActionCounter<<A extends CounterAction<dynamic, dynamic>, B extends MessageBrokerAction<dynamic, dynamic>, C>>(counter: $counter)";
  }
}

final class AppActionMessageBroker<
  A extends CounterAction<dynamic, dynamic>,
  B extends MessageBrokerAction<dynamic, dynamic>,
  C
>
    extends AppAction<A, B, C> {
  final B messageBroker;
  AppActionMessageBroker(this.messageBroker) : super();

  @override
  int get hashCode => messageBroker.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is AppActionMessageBroker && other.messageBroker == messageBroker;

  @override
  String toString() {
    return "AppActionMessageBroker<<A extends CounterAction<dynamic, dynamic>, B extends MessageBrokerAction<dynamic, dynamic>, C>>(messageBroker: $messageBroker)";
  }
}

final class AppActionOnInitState<
  A extends CounterAction<dynamic, dynamic>,
  B extends MessageBrokerAction<dynamic, dynamic>,
  C
>
    extends AppAction<A, B, C> {
  AppActionOnInitState() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) => other is AppActionOnInitState;

  @override
  String toString() {
    return "AppActionOnInitState<<A extends CounterAction<dynamic, dynamic>, B extends MessageBrokerAction<dynamic, dynamic>, C>>";
  }
}

extension AppActionPath on AppAction {
  static final counter =
      WritableKeyPath<AppAction, CounterAction<dynamic, dynamic>?>(
        get: (action) {
          if (action is AppActionCounter) {
            return action.counter;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = AppActionEnum.counter(propAction);
          }
          return rootAction!;
        },
      );
  static final messageBroker =
      WritableKeyPath<AppAction, MessageBrokerAction<dynamic, dynamic>?>(
        get: (action) {
          if (action is AppActionMessageBroker) {
            return action.messageBroker;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = AppActionEnum.messageBroker(propAction);
          }
          return rootAction!;
        },
      );
  static final onInitState = WritableKeyPath<AppAction, AppActionOnInitState?>(
    get: (action) {
      if (action is AppActionOnInitState) {
        return action;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = AppActionEnum.onInitState();
      }
      return rootAction!;
    },
  );
}

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
    return "CounterActionDecrementButtonTapped<<A, B>>";
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
    return "CounterActionIncrementButtonTapped<<A, B>>";
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

extension MessageBrokerActionEnum on MessageBrokerAction {
  static MessageBrokerAction decrementExternal() =>
      MessageBrokerActionDecrementExternal();
  static MessageBrokerAction incrementExternal() =>
      MessageBrokerActionIncrementExternal();
}

final class MessageBrokerActionDecrementExternal<A, B>
    extends MessageBrokerAction<A, B> {
  MessageBrokerActionDecrementExternal() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is MessageBrokerActionDecrementExternal;

  @override
  String toString() {
    return "MessageBrokerActionDecrementExternal<<A, B>>";
  }
}

final class MessageBrokerActionIncrementExternal<A, B>
    extends MessageBrokerAction<A, B> {
  MessageBrokerActionIncrementExternal() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is MessageBrokerActionIncrementExternal;

  @override
  String toString() {
    return "MessageBrokerActionIncrementExternal<<A, B>>";
  }
}

extension MessageBrokerActionPath on MessageBrokerAction {
  static final decrementExternal = WritableKeyPath<
    MessageBrokerAction,
    MessageBrokerActionDecrementExternal?
  >(
    get: (action) {
      if (action is MessageBrokerActionDecrementExternal) {
        return action;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = MessageBrokerActionEnum.decrementExternal();
      }
      return rootAction!;
    },
  );
  static final incrementExternal = WritableKeyPath<
    MessageBrokerAction,
    MessageBrokerActionIncrementExternal?
  >(
    get: (action) {
      if (action is MessageBrokerActionIncrementExternal) {
        return action;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = MessageBrokerActionEnum.incrementExternal();
      }
      return rootAction!;
    },
  );
}
