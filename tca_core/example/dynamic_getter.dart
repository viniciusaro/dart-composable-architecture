import 'package:composable_architecture/composable_architecture.dart';

part 'dynamic_getter.g.dart';

class Store<T> {
  final T state;

  Store({required this.state});

  Prop get<Prop>(KeyPath<T, Prop> keyPath) {
    return keyPath.get(state);
  }
}

@KeyPathable()
class State {
  final int id;
  State(this.id);
}

void main() {
  final store = Store(state: State(1));
  print("state id: ${store.state.id}"); // state id: 1
  print("state id (key path): ${store.get(StatePath.id)}"); // state id (key path): 1
}
