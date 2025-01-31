# The Composable Architecture - Dart

Port of [The Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture) (TCA, for short) for the [Dart Language](https://dart.dev) and [Flutter Framework](https://flutter.dev).

## Basic Usage

To build a feature using the Composable Architecture you define some types and values that model your domain:

State: A type that describes the data your feature needs to perform its logic and render its UI.
Action: A type that represents all of the actions that can happen in your feature, such as user actions, notifications, event sources and more.
Reducer: A function that describes how to evolve the current state of the app to the next state given an action. The reducer is also responsible for returning any effects that should be run, such as API requests, which can be done by returning an Effect value.
Store: The runtime that actually drives your feature. You send all user actions to the store so that the store can run the reducer and effects, and you can observe state changes in the store so that you can update UI.
The benefits of doing this are that you will instantly unlock testability of your feature, and you will be able to break large, complex features into smaller domains that can be glued together.

As a basic example, consider a UI that shows a number along with "+" and "−" buttons that increment and decrement the number. To make things interesting, suppose there is also a button that when tapped makes an API request to fetch a random fact about that number and displays it in the view.

To implement this feature we start by defining a new type for the feature's state, which consists of an integer for the current count, as well as an optional string that represents the fact being presented:

```dart
@KeyPathable()
final class FeatureState {
  int count = 0;
  String? numberFact;
}
```

We also need to define a type for the feature's actions. There are the obvious actions, such as tapping the decrement button, increment button, or fact button. But there are also some slightly non-obvious ones, such as the action that occurs when we receive a response from the fact API request:

```dart 
@CaseKeyPathable()
final class FeatureAction<
    DecrementButtonTapped,
    IncrementButtonTapped,
    NumberFactButtonTapped,
    NumberFactResponse extends NumberFactResponseValue //
    > {}

final class NumberFactResponseValue {
  final String value;
  NumberFactResponseValue(this.value);
}
```

And then we implement the reducer function, which is responsible for composing the actual logic and behavior for the feature. In it we can describe how to change the current state to the next state, and what effects need to be executed. Some actions don't need to execute effects, and they can return `.none()` to represent that:

```dart
Effect<FeatureAction> featureReducer(Inout<FeatureState> state, FeatureAction action) {
  switch (action) {
    case FeatureActionDecrementButtonTapped():
      state.mutate((s) => s..count -= 1);
      return Effect.none();

    case FeatureActionIncrementButtonTapped():
      state.mutate((s) => s..count += 1);
      return Effect.none();

    case FeatureActionNumberFactButtonTapped():
      return Effect.future(() {
        final uri = Uri.parse("http://numbersapi.com/${state.value.count})/trivia");
        return http.post(uri).then(
              (response) => FeatureAction.numberFactResponse(
                NumberFactResponseValue(response.body),
              ),
            );
      });
      
    case FeatureActionNumberFactResponse():
      state.mutate((s) => s..numberFact = action.numberFactResponse.value);
      return Effect.none();
  }
  throw Exception("invalid action");
}
```