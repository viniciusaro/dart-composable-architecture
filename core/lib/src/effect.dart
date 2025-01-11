final class Effect<Action> {
  final void Function(void Function(Action)) run;
  Effect(this.run);

  static Effect<Action> none<Action>() {
    return Effect((_) {});
  }
}
