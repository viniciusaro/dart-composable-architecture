import 'dart:async';
import 'dart:math';

import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'udp_multicast_service.dart';

part 'device_id_client.dart';
part 'message_broker_client.dart';
part 'message.dart';
part 'stream.dart';

final deviceIdClient = liveDeviceIdClient;
final messageBrokerClient = udpMulticastMessageBrokerClient;

@KeyPathable()
final class AppState {
  int count = 0;

  @override
  String toString() {
    return "AppState($count)";
  }
}

@CaseKeyPathable()
final class AppAction<
  DecrementButtonTapped,
  DecrementExternal,
  IncrementButtonTapped,
  IncrementExternal,
  OnInitState //
> {}

Effect<AppAction> counterReducer(Inout<AppState> state, AppAction action) {
  switch (action) {
    case AppActionDecrementButtonTapped():
      state.mutate((s) => s..count -= 1);
      return Effect.none();
    case AppActionIncrementButtonTapped():
      state.mutate((s) => s..count += 1);
      return Effect.none();
  }
  return Effect.none();
}

Effect<AppAction> messageBrokerCounterReducer(Inout<AppState> state, AppAction action) {
  switch (action) {
    case AppActionDecrementButtonTapped():
      return Effect.async(() => messageBrokerClient.publish("decrement"));
    case AppActionDecrementExternal():
      state.mutate((s) => s..count -= 1);
      return Effect.none();
    case AppActionIncrementButtonTapped():
      return Effect.async(() => messageBrokerClient.publish("increment"));
    case AppActionIncrementExternal():
      state.mutate((s) => s..count += 1);
      return Effect.none();
    case AppActionOnInitState():
      return Effect.stream(() {
        return messageBrokerClient.listen().map((message) {
          switch (message.action) {
            case "decrement":
              return AppAction.decrementExternal();
            case "increment":
              return AppAction.incrementExternal();
            default:
              throw Exception("invalid action: $message");
          }
        });
      });
    default:
      return Effect.none();
  }
}

class AppWidget extends StatelessWidget {
  final Store<AppState, AppAction> store;

  const AppWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Realtime Counter Sync")),
      body: WithViewStore(
        store,
        onInitState: (viewstore) {
          viewstore.send(AppAction.onInitState());
        },
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
                      onPressed: () => viewStore.send(AppAction.incrementButtonTapped()),
                      child: Text("+"),
                    ),
                    ElevatedButton(
                      onPressed: () => viewStore.send(AppAction.decrementButtonTapped()),
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

Future<void> main() async {
  final appReducer = combine([
    counterReducer, //
    messageBrokerCounterReducer, //
  ]);

  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: AppWidget(store: Store(initialState: AppState(), reducer: debug(appReducer))),
      ),
    ),
  );
}
