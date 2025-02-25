part of '../store.dart';

final class EffectfullStateMutation extends Equatable implements Exception {
  @override
  String toString() {
    return "EffectfullStateMutation: State mutation detected while running effect";
  }

  @override
  List<Object?> get props => [];
}
