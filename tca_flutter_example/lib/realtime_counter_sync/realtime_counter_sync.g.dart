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

mixin _$AppState {
  CounterState get counter;
  AppState copyWith({CounterState? counter}) {
    return AppState(counter: counter ?? this.counter);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(counter, other.counter);
  @override
  int get hashCode => Object.hash(runtimeType, counter);
  @override
  String toString() {
    return "AppState(counter: $counter)";
  }
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
    return "AppActionCounter.$counter";
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
    return "AppActionMessageBroker.$messageBroker";
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
    return "AppActionOnInitState()";
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
