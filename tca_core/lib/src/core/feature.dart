part of 'store.dart';

abstract class Feature<State, Action> with Reducer<State, Action> {
  Reducer<State, Action> build();

  @override
  Effect<Action> run(Inout<State> state, Action action) {
    return build().run(state, action);
  }
}
