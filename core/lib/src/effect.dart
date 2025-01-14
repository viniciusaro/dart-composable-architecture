part of 'store.dart';

final class Effect<Action> {
  final dynamic id;
  final dynamic cancellationId;
  final Stream<Action> Function() builder;

  const Effect._({
    required this.id,
    required this.cancellationId,
    required this.builder,
  });

  static Effect<A> stream<ID, A>(ID id, Stream<A> Function() builder) => Effect<A>._(
        id: id,
        cancellationId: null,
        builder: builder,
      );

  static Effect<A> future<A>(Future<A> Function() builder) => Effect<A>._(
        id: null,
        cancellationId: null,
        builder: () => builder().asStream(),
      );

  static Effect<A> cancel<ID, A>(ID id) => Effect<A>._(
        id: null,
        cancellationId: id,
        builder: () => Stream.empty(),
      );

  static Effect<A> none<A>() => Effect<A>._(
        id: null,
        cancellationId: null,
        builder: () => Stream.empty(),
      );
}

extension Effects on Effect {
  static Effect<Action> merge<Action>(
    List<Effect<Action>> effects,
  ) {
    return Effect<Action>._(
      id: effects.firstOrNull?.id, // TODO update
      cancellationId: effects.firstOrNull?.cancellationId, // TODO update
      builder: () {
        return StreamGroup.merge(effects.map((e) => e.builder()));
      },
    );
  }
}
