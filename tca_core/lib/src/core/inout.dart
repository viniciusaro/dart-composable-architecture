part of 'store.dart';

final class Inout<T> {
  T _value;
  T get value => _value;

  bool _isMutationAllowed = false;
  bool _didCallMutate = false;
  Inout({required T value}) : _value = value;

  T mutate(T Function(T) mutation) {
    _didCallMutate = true;
    if (_isMutationAllowed) {
      _value = mutation(_value);
      return _value;
    } else {
      throw EffectfullStateMutation();
    }
  }
}
