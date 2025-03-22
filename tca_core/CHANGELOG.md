## 0.0.1

First release of the Composable Architecture port for Dart! This version includes the core concepts from the original library: Store, Reducer, Effect, State, and Actions. Additionally, it provides several operators for reducer composition, enabling simple apps to be built using the available tools.

Testing is a key focus of this release, offering exhaustive state testing and action verification, making it one of the most comprehensive testing solutions compared to other Dart/Flutter state management approaches.

Finally, this version introduces a preliminary v0 implementation of the Shared type, which allows different features to share pieces of state without requiring complex synchronization logic—while maintaining full testing capabilities.

## 0.0.2

Adds support to optional state, allowing reducers to run and local stores to be viewed only when their associated state is available.

## 0.0.3

Update code formatting and add example.md.

## 0.0.4

Adds navigation support and examples with [NavigationDestination] widget and [Presents]/[Presentable] types in the core library.

## 0.0.5

Fix: remove automatic [Store] state clean up on [NavigationDestination] and associated types (Disposable).

## 0.0.6

Feat: make use of Presents reference semantics to implement automatic [Store] state clean up on [NavigationDestination], propagating the change up in the store tree.