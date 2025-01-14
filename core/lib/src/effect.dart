import 'dart:async';

typedef Mutation<State> = State Function(State);

sealed class Effect<State, Action> {
  Mutation<State>? get mutation;

  static Effect<State, Action> sync<State, Action>(
    Mutation<State>? mutation,
  ) => //
      RunEffect(mutation, (_) {});

  static Effect<State, Action> future<State, Action>({
    Mutation<State>? mutation,
    required Future<Action> Function() run,
  }) => //
      FutureEffect<State, Action>(mutation, run);

  static Effect<State, Action> run<State, Action>({
    Mutation<State>? mutation,
    required void Function(void Function(Action)) run,
  }) => //
      RunEffect<State, Action>(mutation, run);

  static Effect<State, Action> stream<State, Action>({
    Mutation<State>? mutation,
    required dynamic id,
    required Stream<Action> Function() run,
  }) => //
      StreamEffect(mutation, id, run);

  static Effect<State, Action> cancel<State, Action>({
    Mutation<State>? mutation,
    required dynamic id,
  }) => //
      CancelEffect(mutation, id);
}

final class CancelEffect<State, Action> extends Effect<State, Action> {
  @override
  final Mutation<State>? mutation;

  final dynamic id;
  CancelEffect(this.mutation, this.id);
}

final class FutureEffect<State, Action> extends Effect<State, Action> {
  @override
  final Mutation<State>? mutation;

  final Future<Action> Function() run;
  FutureEffect(this.mutation, this.run);
}

final class RunEffect<State, Action> extends Effect<State, Action> {
  @override
  final Mutation<State>? mutation;

  final void Function(void Function(Action)) run;
  RunEffect(this.mutation, this.run);
}

final class StreamEffect<State, Action> extends Effect<State, Action> {
  @override
  final Mutation<State>? mutation;
  final dynamic id;
  final Stream<Action> Function() run;
  StreamEffect(this.mutation, this.id, this.run);
}
