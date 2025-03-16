# The Composable Architecture - Dart (experimental)

Port of [The Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture) (TCA, for short) for the [Dart Language](https://dart.dev) and [Flutter Framework](https://flutter.dev).

- [Examples](#examples)
- [Basic Usage](#basic-usage)
- [Setup](#setup)

## Examples
https://github.com/user-attachments/assets/27af38b1-189b-4f59-8710-f41026ca20fa

This repo comes with _lots_ of examples to demonstrate how to solve common and complex problems with 
the Composable Architecture. Check out [this](https://github.com/viniciusaro/dart-composable-architecture/tree/main/tca_flutter_example/lib) directory to see them all, including:

* [Feature Composition](https://github.com/viniciusaro/dart-composable-architecture/tree/main/tca_flutter_example/lib/feature_composition)
* [Number Fact](https://github.com/viniciusaro/dart-composable-architecture/blob/main/tca_flutter_example/lib/number_fact/number_fact.dart)
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

And then we implement the reducer function, which is responsible for composing the actual logic and behavior for the feature. In it we can describe how to change the current state to the next state, and what effects need to be executed. Some actions don't need to execute effects, and they can return `.none()` to represent that:

```dart
Effect<NumberFactAction> numberFactReducer(Inout<NumberFactState> state, NumberFactAction action) {
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
        final uri = Uri.parse("http://numbersapi.com/${state.value.count}/trivia");
        final response = await http.get(uri);
        return NumberFactActionEnum.numberFactResponse(response.body);
      });

    case NumberFactActionNumberFactResponse():
      state.mutate((s) => s.copyWith(isLoading: false, numberFact: action.numberFactResponse));
      return Effect.none();
  }
}
```

And then finally we define the widget that displays the feature. It holds onto a `Store<FeatureState, FeatureAction>` and wraps it's body in a `WithViewStore<FeatureState, FeatureAction>` so that it can observe all changes to the state and re-render. We can send all user actions to the store so that state changes:

```dart
class NumberFactWidget extends StatelessWidget {
  final Store<NumberFactState, NumberFactAction> store;

  const NumberFactWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return WithViewStore<NumberFactState, NumberFactAction>(
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

![Simulator Screen Recording - iPhone 16 Pro - 2025-01-31 at 11 07 36](https://github.com/user-attachments/assets/6d94c617-0318-48ba-806a-0b7d6ca50a93)


# Setup

This package relies on code generation to enhance the developer experience and improve coding ergonomics. It includes built-in generators that create KeyPaths for states and actions in types annotated with @KeyPathable and @CaseKeyPathable.

However, the generated code has some basic requirements: types conforming to @KeyPathable must implement a copyWith method. Users can provide this method however they prefer, but the recommended approach is to use a generator—specifically, [@freezed](https://pub.dev/packages/freezed).

To enable these additional generators, you must explicitly add them as dependencies in your `pubspec.yaml`:
```yaml
dependencies:
  composable_architecture: ...
  freezed: ...
```

Additionally, to run the generators, you need to include [build_runner](https://pub.dev/packages/build_runner) as a development dependency:

```yaml
dev_dependencies:
  build_runner: ...
```

If you are using Flutter, you need to depend on `composable_architecture_flutter`. This is the case because even though `composable_architecture_flutter` explicitly depends on `composable_architecture`, build_runner needs the direct dependency on `composable_architecture` to get access to the generators.

```yaml
dependencies:
  composable_architecture: ...
  composable_architecture_flutter: ...
  freezed: ...
```

The `freezed_annotation` package is already included and exported by `composable_architecture`, so you don’t need to add it manually.

Finally, for the generators to work, you must add part directives in the file containing the type annotations, in addition to importing composable_architecture:

```dart
import 'package:composable_architecture/composable_architecture.dart';

part 'your_file_name.freezed.dart';
part 'your_file_name.g.dart';

@freezed
@KeyPathable()
final class YourState with _$YourState {}
```

You can replace freezed with any other generator that provides a `copyWith` method, or even add the method yourself. In each case, update the part directives according to the documentation of the chosen tool.