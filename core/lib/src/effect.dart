import 'dart:async';

part 'effect_with_checks.dart';

sealed class Effect<Action> {
  static Effect<Action> none<Action>() => //
      RunEffect((_) {});

  static Effect<Action> future<Action>(
    Future<Action> Function() run,
  ) => //
      FutureEffect<Action>(run);

  static Effect<Action> run<Action>(
    void Function(void Function(Action)) run,
  ) => //
      RunEffect<Action>(run);

  static Effect<Action> stream<Action>(
    dynamic id,
    Stream<Action> Function() run,
  ) => //
      StreamEffect(id, run);

  static Effect<Action> cancel<Action>(
    dynamic id,
  ) => //
      CancelEffect(id);
}

final class CancelEffect<Action> extends Effect<Action> {
  final dynamic id;
  CancelEffect(this.id);
}

final class FutureEffect<Action> extends Effect<Action> {
  final Future<Action> Function() run;
  FutureEffect(this.run);
}

final class RunEffect<Action> extends Effect<Action> {
  final void Function(void Function(Action)) run;
  RunEffect(this.run);
}

final class StreamEffect<Action> extends Effect<Action> {
  final dynamic id;
  final Stream<Action> Function() run;
  StreamEffect(this.id, this.run);
}
