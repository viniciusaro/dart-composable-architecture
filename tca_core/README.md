> 🎙️⚠️
> 
> I would love community insights and help for taking next steps.
> 
> If you feel like contributing, join discussions [here](https://github.com/viniciusaro/dart-composable-architecture/discussions)!

# The Composable Architecture - Dart (experimental)

[![pub package](https://img.shields.io/pub/v/composable_architecture.svg)](https://pub.dev/packages/composable_architecture)

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
