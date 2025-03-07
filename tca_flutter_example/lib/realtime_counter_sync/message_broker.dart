import 'package:composable_architecture/composable_architecture.dart';

import 'clients/message_broker_client/message_broker_client.dart';
import 'counter.dart';
import 'realtime_counter_sync.dart';

part 'message_broker.g.dart';

@CaseKeyPathable()
sealed class MessageBrokerAction<
  DecrementExternal,
  IncrementExternal //
> {}

Effect<AppAction> messageBrokerReducer(Inout<AppState> state, AppAction action) {
  switch (action) {
    case AppActionCounter():
      switch (action.counter) {
        case CounterActionDecrementButtonTapped():
          return Effect.async(() => messageBrokerClient.publish("decrement"));
        case CounterActionIncrementButtonTapped():
          return Effect.async(() => messageBrokerClient.publish("increment"));
      }
    case AppActionMessageBroker():
      switch (action.messageBroker) {
        case MessageBrokerActionDecrementExternal():
          state.mutate((s) => s.copyWith(counter: s.counter.copyWith(count: s.counter.count - 1)));
          return Effect.none();
        case MessageBrokerActionIncrementExternal():
          state.mutate((s) => s.copyWith(counter: s.counter.copyWith(count: s.counter.count + 1)));
          return Effect.none();
      }

    case AppActionOnInitState():
      return Effect.stream(() {
        return messageBrokerClient.listen().map((message) {
          switch (message.action) {
            case "decrement":
              return AppActionEnum.messageBroker(MessageBrokerActionEnum.decrementExternal());
            case "increment":
              return AppActionEnum.messageBroker(MessageBrokerActionEnum.incrementExternal());
            default:
              throw Exception("invalid action: $message");
          }
        });
      });
  }
}
