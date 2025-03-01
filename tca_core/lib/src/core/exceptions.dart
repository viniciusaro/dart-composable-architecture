part of 'store.dart';

final class EffectfullStateMutation extends Equatable implements Exception {
  @override
  String toString() {
    return "EffectfullStateMutation: State mutation detected outside reducer";
  }

  @override
  List<Object?> get props => [];
}
