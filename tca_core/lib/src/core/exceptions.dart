part of 'store.dart';

final class EffectfullStateMutation implements Exception {
  @override
  String toString() {
    return "EffectfullStateMutation: State mutation detected outside reducer";
  }

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) {
    return other is EffectfullStateMutation;
  }
}
