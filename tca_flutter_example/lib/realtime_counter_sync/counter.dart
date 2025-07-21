import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

part 'counter.g.dart';

@KeyPathable()
final class CounterState with _$CounterState {
  @override
  final int count;
  const CounterState({this.count = 0});
}

@CaseKeyPathable()
sealed class CounterAction<
  DecrementButtonTapped,
  IncrementButtonTapped //
> {}

final class CounterFeature extends Feature<CounterState, CounterAction> {
  @override
  Reducer<CounterState, CounterAction> build() {
    return Reduce((state, action) {
      switch (action) {
        case CounterActionDecrementButtonTapped():
          state.mutate((s) => s.copyWith(count: s.count - 1));
          return Effect.none();
        case CounterActionIncrementButtonTapped():
          state.mutate((s) => s.copyWith(count: s.count + 1));
          return Effect.none();
      }
    });
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
                      onPressed: () {
                        viewStore.send(
                          CounterActionEnum.incrementButtonTapped(),
                        );
                      },
                      child: Text("+"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        viewStore.send(
                          CounterActionEnum.decrementButtonTapped(),
                        );
                      },
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
