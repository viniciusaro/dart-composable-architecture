// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_broker.dart';

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

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
    return "MessageBrokerActionDecrementExternal()";
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
    return "MessageBrokerActionIncrementExternal()";
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
