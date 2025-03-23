import 'dart:async';

import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

import 'counter.dart';
import 'message_broker.dart';

part 'realtime_counter_sync.freezed.dart';
part 'realtime_counter_sync.g.dart';

@freezed
@KeyPathable()
final class AppState with _$AppState {
  @override
  final CounterState counter;
  const AppState({this.counter = const CounterState()});
}

@CaseKeyPathable()
sealed class AppAction<
  Counter extends CounterAction,
  MessageBroker extends MessageBrokerAction,
  OnInitState //
> {}

final class AppFeature extends Feature<AppState, AppAction> {
  @override
  Reducer<AppState, AppAction> build() {
    return Reduce.combine([
      Scope(
        state: AppStatePath.counter,
        action: AppActionPath.counter,
        feature: CounterFeature(),
      ),
      MessageBrokerFeature(),
    ]);
  }
}

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
        body: AppWidget(
          store: Store(
            initialState: AppState(),
            reducer: AppFeature().debug(), //
          ),
        ),
      ),
    ),
  );
}
