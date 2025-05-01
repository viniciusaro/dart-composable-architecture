import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

part 'instrumentation.freezed.dart';
part 'instrumentation.g.dart';

@freezed
final class CounterState with _$CounterState {
  @override
  final int count;
  CounterState([this.count = 0]);
}

@CaseKeyPathable()
sealed class CounterAction<
  IncrementButtonTapped //
> {}

final class CounterFeature extends Feature<CounterState, CounterAction> {
  final bool throwableMutation;

  CounterFeature({this.throwableMutation = false});

  @override
  Reducer<CounterState, CounterAction> build() {
    return CrashLogger(
      Reduce.combine([
        Reduce((state, action) {
          switch (action) {
            case CounterActionIncrementButtonTapped():
              state.mutate((s) {
                if (throwableMutation) {
                  throw Exception("divided by zero");
                } else {
                  return s.copyWith(count: s.count + 1);
                }
              });
              return Effect.none();
          }
        }),
        Analytcs(),
      ]),
    );
  }
}

class CounterWidget extends StatelessWidget {
  final Store<CounterState, CounterAction> store;

  const CounterWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Analytics")),
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

void main() {
  crashLoggerClient = consoleCrashLoggerClient;
  analyticsClient = consoleAnalyticsClient;

  runApp(
    MaterialApp(
      home: CounterWidget(
        store: Store(
          initialState: CounterState(),
          reducer: CounterFeature().debug(), //
        ),
      ),
    ),
  );
}
