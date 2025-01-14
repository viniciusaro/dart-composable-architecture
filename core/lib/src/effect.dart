import 'dart:async';

import 'package:async/async.dart';

typedef Mutation<State> = State Function(State);

final class Effect<State, Action> {
  final dynamic id;
  final dynamic cancellationId;
  final Mutation<State>? mutation;
  final Stream<Action> Function() builder;

  Effect({
    required this.id,
    required this.cancellationId,
    required this.mutation,
    required this.builder,
  });

  static Effect<S, A> mutate<S, A>(Mutation<S> mutation) => Effect<S, A>(
        id: null,
        cancellationId: null,
        mutation: mutation,
        builder: () => Stream.empty(),
      );

  static Effect<S, A> stream<ID, S, A>(ID id, Stream<A> Function() builder) => Effect<S, A>(
        id: id,
        cancellationId: null,
        mutation: null,
        builder: builder,
      );

  static Effect<S, A> future<S, A>(Future<A> Function() builder) => Effect<S, A>(
        id: null,
        cancellationId: null,
        mutation: null,
        builder: () => builder().asStream(),
      );

  static Effect<S, A> cancel<ID, S, A>(ID id) => //
      Effect<S, A>(
        id: null,
        cancellationId: id,
        mutation: null,
        builder: () => Stream.empty(),
      );
}

extension Effects on Effect {
  static Effect<State, Action> merge<Action, State>(
    List<Effect<State, Action>> effects,
  ) {
    return Effect<State, Action>(
      id: effects.firstOrNull?.id, // TODO update
      cancellationId: effects.firstOrNull?.cancellationId, // TODO update
      mutation: (state) {
        var updated = state;
        for (final effect in effects) {
          updated = effect.mutation?.call(updated) ?? updated;
        }
        return updated;
      },
      builder: () {
        return StreamGroup.merge(effects.map((e) => e.builder()));
      },
    );
  }
}
