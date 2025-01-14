import 'dart:async';

import 'package:async/async.dart';

typedef Mutation<State> = State Function(State);

final class Effect<State, Action> {
  final dynamic id;
  final Mutation<State>? mutation;
  final Stream<EffectAction<Action>> Function() builder;

  Effect(this.id, this.mutation, this.builder);

  static Effect<S, A> mutate<S, A>(Mutation<S> mutation) =>
      Effect<S, A>(null, mutation, () => Stream.empty());

  static Effect<S, A> stream<ID, S, A>(ID id, Stream<A> Function() builder) =>
      Effect<S, A>(id, null, () => builder().map(Forward.new));

  static Effect<S, A> future<S, A>(Future<A> Function() builder) =>
      Effect<S, A>(null, null, () => builder().asStream().map(Forward.new));

  static Effect<S, A> cancel<ID, S, A>(ID id) => //
      Effect<S, A>(id, null, () => Stream.value(Cancel()));
}

extension Effects on Effect {
  static Effect<State, Action> merge<Action, State>(
    Effect<State, Action> effectA,
    Effect<State, Action> effectB,
  ) {
    return Effect<State, Action>(
      null,
      (state) {
        final updateA = effectA.mutation?.call(state) ?? state;
        final updateB = effectB.mutation?.call(updateA) ?? updateA;
        return updateB;
      },
      () {
        return StreamGroup.merge([effectA.builder(), effectB.builder()]);
      },
    );
  }
}

sealed class EffectAction<Action> {}

final class Cancel<Action> extends EffectAction<Action> {}

final class Forward<Action> extends EffectAction<Action> {
  final Action action;
  Forward(this.action);
}
