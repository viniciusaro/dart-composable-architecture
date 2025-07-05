> 🎙️⚠️
> 
> I would love community insights and help for taking next steps.
> 
> If you feel like contributing, join discussions [here](https://github.com/viniciusaro/dart-composable-architecture/discussions)!

# The Composable Architecture - Dart (experimental)

Port of [The Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture) (TCA, for short) for the [Dart Language](https://dart.dev) and [Flutter Framework](https://flutter.dev).

- [Examples](#examples)
- [Basic Usage](https://github.com/viniciusaro/dart-composable-architecture/blob/main/tca_core/example/example.md)
- [Setup](#setup)

## Examples
https://github.com/user-attachments/assets/27af38b1-189b-4f59-8710-f41026ca20fa

This repo comes with _lots_ of examples to demonstrate how to solve common and complex problems with 
the Composable Architecture. Check out [this](https://github.com/viniciusaro/dart-composable-architecture/tree/main/tca_flutter_example/lib) directory to see them all, including:

* [Feature Composition](https://github.com/viniciusaro/dart-composable-architecture/tree/main/tca_flutter_example/lib/feature_composition)
* [Number Fact](https://github.com/viniciusaro/dart-composable-architecture/blob/main/tca_flutter_example/lib/number_fact/number_fact.dart)
* [Optional State](https://github.com/viniciusaro/dart-composable-architecture/blob/main/tca_flutter_example/lib/optional_state/optional_state.dart)
* [Realtime Counter Sync](https://github.com/viniciusaro/dart-composable-architecture/blob/main/tca_flutter_example/lib/realtime_counter_sync/realtime_counter_sync.dart)

## Setup

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

If you are using Flutter, you need to explicitly depend on both `composable_architecture` and `composable_architecture_flutter`. This is the case because even though `composable_architecture_flutter` depends on `composable_architecture`, build_runner needs the direct dependency on `composable_architecture` to get access to the generators.

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
