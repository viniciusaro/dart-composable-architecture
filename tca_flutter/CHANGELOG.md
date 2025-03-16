## 0.0.1

First release of the Composable Architecture port for Flutter! This version includes the core concepts from the original library: Store, Reducer, Effect, State, and Actions. Additionally, it provides several operators for reducer composition, enabling simple apps to be built using the available tools.

Testing is a key focus of this release, offering exhaustive state testing and action verification, making it one of the most comprehensive testing solutions compared to other Dart/Flutter state management approaches.

Finally, this version introduces a preliminary v0 implementation of the Shared type, which allows different features to share pieces of state without requiring complex synchronization logic—while maintaining full testing capabilities.

## 0.0.2

Make store property public just to update autocomplete placeholder with "store" instead of "_store". If public visibility for the field becomes an issue we can change in the future.
