import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(home: Counter(store: Store(initialState: CounterState(), reducer: counterReducer))),
  );
}

@KeyPathable()
final class CounterState {
  int count = 0;
}

@CaseKeyPathable()
final class CounterAction<Increment, Decrement> {}

Effect<CounterAction> counterReducer(Inout<CounterState> state, CounterAction action) {
  switch (action) {
    case CounterActionIncrement():
      state.mutate((s) => s..count += 1);
      return Effect.none();
    case CounterActionDecrement():
      state.mutate((s) => s..count -= 1);
      return Effect.none();
  }
  return Effect.none();
}

class Counter extends StatelessWidget {
  final Store<CounterState, CounterAction> store;

  const Counter({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return WithViewStore<CounterState, CounterAction>(
      store,
      body: (viewStore) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Count: ${viewStore.state.count}"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        viewStore.send(CounterAction.increment());
                      },
                      child: Text("+"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        viewStore.send(CounterAction.decrement());
                      },
                      child: Text("-"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
