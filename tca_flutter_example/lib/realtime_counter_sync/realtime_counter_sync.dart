import 'dart:async';

import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

import 'clients/message_broker_client/message_broker_client.dart';

part 'realtime_counter_sync.g.dart';

@KeyPathable()
final class AppState {
  CounterState counter = CounterState();

  @override
  String toString() {
    return "AppState(counter: $counter)";
  }
}

@CaseKeyPathable()
sealed class AppAction<
  Counter extends CounterAction,
  MessageBroker extends MessageBrokerAction,
  OnInitState //
> {}

final appReducer = combine([
  pullback(counterReducer, state: AppStatePath.counter, action: AppActionPath.counter),
  messageBrokerReducer,
]);

class AppWidget extends StatelessWidget {
  final Store<AppState, AppAction> store;

  const AppWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return WithViewStore(
      store,
      onInitState: (store) {
        return store.send(AppActionEnum.onInitState());
      },
      body: (store) {
        return CounterWidget(
          store: store.view(
            state: AppStatePath.counter,
            action: AppActionPath.counter, //
          ),
        );
      },
    );
  }
}

@KeyPathable()
final class CounterState {
  int count = 0;

  @override
  String toString() {
    return "CounterState($count)";
  }
}

@CaseKeyPathable()
sealed class CounterAction<
  DecrementButtonTapped,
  IncrementButtonTapped //
> {}

Effect<CounterAction> counterReducer(Inout<CounterState> state, CounterAction action) {
  switch (action) {
    case CounterActionDecrementButtonTapped():
      state.mutate((s) => s..count -= 1);
      return Effect.none();
    case CounterActionIncrementButtonTapped():
      state.mutate((s) => s..count += 1);
      return Effect.none();
  }
}

class CounterWidget extends StatelessWidget {
  final Store<CounterState, CounterAction> store;

  const CounterWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Realtime Counter Sync")),
      body: WithViewStore(
        store,
        body: (viewStore) {
          return Center(
            child: Column(
              spacing: 8,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Count: ${viewStore.state.count}"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => viewStore.send(CounterActionEnum.incrementButtonTapped()),
                      child: Text("+"),
                    ),
                    ElevatedButton(
                      onPressed: () => viewStore.send(CounterActionEnum.decrementButtonTapped()),
                      child: Text("-"),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

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
          state.mutate((s) => s..counter.count -= 1);
          return Effect.none();
        case MessageBrokerActionIncrementExternal():
          state.mutate((s) => s..counter.count += 1);
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

Future<void> main() async {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: AppWidget(store: Store(initialState: AppState(), reducer: debug(appReducer))),
      ),
    ),
  );
}
