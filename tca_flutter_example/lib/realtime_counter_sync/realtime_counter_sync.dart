import 'dart:async';

import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

import 'counter.dart';
import 'message_broker.dart';

part 'realtime_counter_sync.freezed.dart';
part 'realtime_counter_sync.g.dart';

@freezed
@KeyPathable()
abstract class AppState with _$AppState {
  factory AppState({
    @Default(CounterState()) CounterState counter, //
  }) = _AppState;
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
