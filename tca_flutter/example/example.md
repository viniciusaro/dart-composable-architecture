## Example

To build a feature using the Composable Architecture you define some types and values that model your domain:

- **State**: A type that describes the data your feature needs to perform its logic and render its UI.
- **Action**: A type that represents all of the actions that can happen in your feature, such as user actions, notifications, event sources and more.
- **Reducer**: A function that describes how to evolve the current state of the app to the next state given an action. The reducer is also responsible for returning any effects that should be run, such as API requests, which can be done by returning an Effect value.
- **Store**: The runtime that actually drives your feature. You send all user actions to the store so that the store can run the reducer and effects, and you can observe state changes in the store so that you can update UI.
The benefits of doing this are that you will instantly unlock testability of your feature, and you will be able to break large, complex features into smaller domains that can be glued together.

As a basic example, consider a UI that shows a number along with "+" and "−" buttons that increment and decrement the number. To make things interesting, suppose there is also a button that when tapped makes an API request to fetch a random fact about that number and displays it in the view.

To implement this feature we start by defining a new type for the feature's state, which consists of an integer for the current count, as well as an optional string that represents the fact being presented:

```dart
@freezed
@KeyPathable()
abstract class NumberFactState with _$NumberFactState {
  factory NumberFactState({
    @Default(0) int count,
    @Default(false) bool isLoading,
    String? numberFact,
  }) = _NumberFactState;
}

```

We also need to define a type for the feature's actions. There are the obvious actions, such as tapping the decrement button, increment button, or fact button. But there are also some slightly non-obvious ones, such as the action that occurs when we receive a response from the fact API request:

```dart 
@CaseKeyPathable()
sealed class NumberFactAction<
  DecrementButtonTapped,
  IncrementButtonTapped,
  NumberFactButtonTapped,
  NumberFactResponse extends String //
> {}
```

And then we implement the [Feature] type, which is responsible for composing the actual logic and behavior for the feature. In the `build` method we can describe how to change the current state to the next state, and what effects need to be executed. Some actions don't need to execute effects, and they can return `.none()` to represent that:

```dart
final class NumberFactFeature extends Feature<NumberFactState, NumberFactAction> {
  @override
  Reducer<NumberFactState, NumberFactAction> build() {
    return Reduce((state, action) {
      switch (action) {
        case NumberFactActionDecrementButtonTapped():
          state.mutate((s) => s.copyWith(count: s.count - 1));
          return Effect.none();

        case NumberFactActionIncrementButtonTapped():
          state.mutate((s) => s.copyWith(count: s.count + 1));
          return Effect.none();

        case NumberFactActionNumberFactButtonTapped():
          state.mutate((s) => s.copyWith(isLoading: true));
          return Effect.future(() async {
            final response = await numberFactClient.factFor(state.value.count);
            return NumberFactActionEnum.numberFactResponse(response);
          });

        case NumberFactActionNumberFactResponse():
          state.mutate(
            (s) => s.copyWith(
              isLoading: false,
              numberFact: action.numberFactResponse,
            ),
          );
          return Effect.none();
      }
    });
  }
}
```

Finally we define the widget that displays the feature. It holds onto a `Store<FeatureState, FeatureAction>` and wraps it's body in a `WithViewStore<FeatureState, FeatureAction>` so that it can observe all changes to the state and re-render. We can send all user actions to the store so that state changes:

```dart
class NumberFactWidget extends StatelessWidget {
  final Store<NumberFactState, NumberFactAction> store;

  const NumberFactWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return WithViewStore(
      store,
      body: (viewStore) {
        return Center(
          child: Column(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Count: ${viewStore.state.count}"),
              ElevatedButton(
                onPressed: () => viewStore.send(NumberFactActionEnum.numberFactButtonTapped()),
                child: Text("Number Fact"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => viewStore.send(NumberFactActionEnum.incrementButtonTapped()),
                    child: Text("+"),
                  ),
                  ElevatedButton(
                    onPressed: () => viewStore.send(NumberFactActionEnum.decrementButtonTapped()),
                    child: Text("-"),
                  ),
                ],
              ),
              if (viewStore.state.isLoading)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: CircularProgressIndicator(),
                )
              else if (viewStore.state.numberFact != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Text("Fact: ${viewStore.state.numberFact}", textAlign: TextAlign.center),
                ),
            ],
          ),
        );
      },
    );
  }
}
```

The final result is something like the following:

![Simulator Screen Recording - iPhone 16 Pro - 2025-03-23 at 12 05 45](https://github.com/user-attachments/assets/dc9b271c-0850-4ba4-9f2d-79286dd82c09)
