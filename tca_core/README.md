> 🎙️⚠️
> 
> I would love community insights and help for taking next steps.
> 
> If you feel like contributing, join discussions [here](https://github.com/viniciusaro/dart-composable-architecture/discussions)!

# The Composable Architecture - Dart (experimental)

[![pub package](https://img.shields.io/pub/v/composable_architecture.svg)](https://pub.dev/packages/composable_architecture)

Port of [The Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture) (TCA, for short) for the [Dart Language](https://dart.dev) and [Flutter Framework](https://flutter.dev).

- [Examples](#examples)
- [Basic Usage](#basic-usage)
- [Testing](#testing)
- [Setup](#setup)

## Examples
https://github.com/user-attachments/assets/27af38b1-189b-4f59-8710-f41026ca20fa

This repo comes with _lots_ of examples to demonstrate how to solve common and complex problems with 
the Composable Architecture. Check out [this](https://github.com/viniciusaro/dart-composable-architecture/tree/main/tca_flutter_example/lib) directory to see them all, including:

* [Feature Composition](https://github.com/viniciusaro/dart-composable-architecture/tree/main/tca_flutter_example/lib/feature_composition)
* [Number Fact](https://github.com/viniciusaro/dart-composable-architecture/blob/main/tca_flutter_example/lib/number_fact/number_fact.dart)
* [Optional State](https://github.com/viniciusaro/dart-composable-architecture/blob/main/tca_flutter_example/lib/optional_state/optional_state.dart)
* [Realtime Counter Sync](https://github.com/viniciusaro/dart-composable-architecture/blob/main/tca_flutter_example/lib/realtime_counter_sync/realtime_counter_sync.dart)

## Basic Usage
To build a feature using the Composable Architecture you define some types and values that model your domain:

- **State**: A type that describes the data your feature needs to perform its logic and render its UI.
- **Action**: A type that represents all of the actions that can happen in your feature, such as user actions, notifications, event sources and more.
- **Reducer**: A function that describes how to evolve the current state of the app to the next state given an action. The reducer is also responsible for returning any effects that should be run, such as API requests, which can be done by returning an Effect value.
- **Store**: The runtime that actually drives your feature. You send all user actions to the store so that the store can run the reducer and effects, and you can observe state changes in the store so that you can update UI.
The benefits of doing this are that you will instantly unlock testability of your feature, and you will be able to break large, complex features into smaller domains that can be glued together.

As a basic example, consider a UI that shows a number along with "+" and "−" buttons that increment and decrement the number. To make things interesting, suppose there is also a button that when tapped makes an API request to fetch a random fact about that number and displays it in the view.

To implement this feature we start by defining a new type for the feature's state, which consists of an integer for the current count, as well as an optional string that represents the fact being presented:

```dart
@KeyPathable()
class NumberFactState with _$NumberFactState {
  @override
  final int count;

  @override
  final bool isLoading;

  @override
  final String? numberFact;

  const NumberFactState({
    this.count = 0,
    this.isLoading = false,
    this.numberFact,
  });
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

## Testing
To test use a TestStore, which can be created with the same information as the Store, but it does extra work to allow you to assert how your feature evolves as actions are sent:

```dart
final store = TestStore(
  initialState: NumberFactState(),
  reducer: NumberFactFeature(),
);
```
Once the test store is created we can use it to make an assertion of an entire user flow of steps. Each step of the way we need to prove that state changed how we expect. For example, we can simulate the user flow of tapping on the increment and decrement buttons:

```dart
store.send(
  NumberFactActionEnum.incrementButtonTapped(),
  (_) => NumberFactState(count: 1), //
);

store.send(
  NumberFactActionEnum.decrementButtonTapped(),
  (_) => NumberFactState(count: 0), //
);
```

Further, if a step causes an effect to be executed, which feeds data back into the store, we must assert on that. For example, if we simulate the user tapping on the fact button we expect to receive a fact response back with the fact, which then causes the numberFact state to be populated:

```dart
numberFactClient = NumberFactClient(
  factFor: (n) async => "$n is a good number",
);

final store = TestStore(
  initialState: NumberFactState(),
  reducer: NumberFactFeature(),
);

store.send(
  NumberFactActionEnum.numberFactButtonTapped(),
  (_) => NumberFactState(isLoading: true), //
);

store.receive(
  NumberFactActionEnum.numberFactResponse("0 is a good number"),
  (_) => NumberFactState(isLoading: false, numberFact: "0 is a good number"),
);
```

## Setup
This package relies on code generation to enhance the developer experience and improve coding ergonomics. It includes built-in generators that create KeyPaths for states and actions in types annotated with @KeyPathable and @CaseKeyPathable.

**Types annotated with `@KeyPathable` automatically get `copyWith`, equality (`==`), `hashCode`, and `toString` methods generated for you.** You do not need to provide your own `copyWith` or equality implementations—these are handled by the code generator.

If you want additional features (like unions, pattern matching, or deep immutability), you can still use [@freezed](https://pub.dev/packages/freezed) or another code generator alongside `@KeyPathable`. In that case, follow the documentation for that tool as well.

To enable the generators, you must explicitly add them as dependencies in your `pubspec.yaml`:
```yaml
dependencies:
  composable_architecture: ...
```

Additionally, to run the generators, you need to include [build_runner](https://pub.dev/packages/build_runner) as a development dependency:

```yaml
dev_dependencies:
  build_runner: ...
```

If you are using Flutter, you need to explicitly depend on both `composable_architecture` and `composable_architecture_flutter`. This is the case because even though `composable_architecture_flutter` depends on `composable_architecture`, build_runner needs the direct dependency on `composable_architecture` to get access to the generators.

```yaml
dependencies:
  composable_architecture: ...
  composable_architecture_flutter: ...
```

Finally, for the generators to work, you must add part directives in the file containing the type annotations, in addition to importing composable_architecture:

```dart
import 'package:composable_architecture/composable_architecture.dart';

part 'your_file_name.g.dart';

@KeyPathable()
final class YourState with _$YourState {}
```
