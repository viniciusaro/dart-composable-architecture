part of 'store.dart';

final class KeyPath<Root, Prop> {
  final Prop Function(Root) get;
  KeyPath({required this.get});

  static WritableKeyPath<A, A> identity<A>() {
    return WritableKeyPath(
        get: (a) => a,
        set: (a, b) {
          a = b;
          return a ?? b;
        });
  }

  static WritableKeyPath<A, A?> identityOptional<A>() {
    return WritableKeyPath(
        get: (a) => a,
        set: (a, b) {
          a = b;
          return a!;
        });
  }
}

final class KeyPathable {
  const KeyPathable();
}

final class CaseKeyPathable {
  const CaseKeyPathable();
}

KeyPath<Root, Prop> path0<Root, Prop>(
  KeyPath<Root, Prop> first,
) {
  return first;
}

KeyPath<Root, Deeper> path<Root, Prop, Deeper>(
  KeyPath<Root, Prop> first,
  KeyPath<Prop, Deeper> second,
) {
  return first.path(second);
}

KeyPath<Root, Deeper> path2<Root, Prop, Deeper>(
  KeyPath<Root, Prop> first,
  KeyPath<Prop, Deeper> second,
) {
  return path(first, second);
}

KeyPath<Root, Deeper> path3<Root, Prop1, Prop2, Deeper>(
  KeyPath<Root, Prop1> first,
  KeyPath<Prop1, Prop2> second,
  KeyPath<Prop2, Deeper> third,
) {
  return first.path(second).path(third);
}

KeyPath<Root, Deeper> path4<Root, Prop1, Prop2, Prop3, Deeper>(
  KeyPath<Root, Prop1> first,
  KeyPath<Prop1, Prop2> second,
  KeyPath<Prop2, Prop3> third,
  KeyPath<Prop3, Deeper> fourth,
) {
  return first.path(second).path(third).path(fourth);
}

KeyPath<Root, Deeper> path5<Root, Prop1, Prop2, Prop3, Prop4, Deeper>(
  KeyPath<Root, Prop1> first,
  KeyPath<Prop1, Prop2> second,
  KeyPath<Prop2, Prop3> third,
  KeyPath<Prop3, Prop4> fourth,
  KeyPath<Prop4, Deeper> fith,
) {
  return first.path(second).path(third).path(fourth).path(fith);
}

extension KeyPathX<Root, Prop> on KeyPath<Root, Prop> {
  KeyPath<Root, Deeper> path<Deeper>(KeyPath<Prop, Deeper> deeper) {
    return KeyPath(get: (Root root) {
      final prop = get(root);
      return deeper.get(prop);
    });
  }
}

final class WritableKeyPath<Root, Prop> implements KeyPath<Root, Prop> {
  @override
  final Prop Function(Root) get;
  final Root Function(Root?, Prop) set;
  WritableKeyPath({required this.get, required this.set});
}

/// Nests two KeyPaths.
///
/// If there is a KeyPath that allows read/write from A to B
/// and another KeyPath that allows read/write from B to C,
/// this function creates a new KeyPath that is able
/// to read/write from A to C.
extension WritableKeyPathObject<Root, Prop extends Object>
    on WritableKeyPath<Root, Prop> {
  WritableKeyPath<Root, Deeper> path<Deeper>(
    WritableKeyPath<Prop, Deeper> deeper,
  ) {
    return WritableKeyPath(get: (Root root) {
      final prop = get(root);
      return deeper.get(prop);
    }, set: (root, deep) {
      final prop = root != null ? get(root) : null;
      final updatedProp = deeper.set(prop, deep);
      final updatedRoot = set(root, updatedProp);
      return updatedRoot;
    });
  }
}

/// Special implementation for [Presents] property with *non* nullable values.
///
/// This is simply syntax sugar for working with the [Presents] type, allowing
/// the user to derive a KeyPath from a Presents property
/// as if it was a normal property.
extension WritableKeyPathPresents<Root, Prop extends Object> //
    on WritableKeyPath<Root, Presents<Prop>> {
  WritableKeyPath<Root, Deeper> path<Deeper>(
    WritableKeyPath<Prop, Deeper> deeper,
  ) {
    return WritableKeyPath(get: (Root root) {
      final prop = get(root);
      return deeper.get(prop.value);
    }, set: (root, deep) {
      final prop = root != null ? get(root) : Presents(null);
      final updatedProp = deeper.set(prop.value, deep);
      final updatedRoot = set(root, Presents(updatedProp));
      return updatedRoot;
    });
  }
}

/// Special implementation for [Presents] property with nullable values.
///
/// In this implementation, when setting null to the property,
/// Presents value is mutated instead of a copy being made.
///
/// This takes advantage of reference type semantis allowing the
/// change to propagate up in the tree. It enables automatic state sync
/// for navigation disposal.
extension WritableKeyPathPresentsOptional<Root, Prop> //
    on WritableKeyPath<Root, Presents<Prop?>> {
  WritableKeyPath<Root, Deeper?> path<Deeper>(
    WritableKeyPath<Prop, Deeper> deeper,
  ) {
    return WritableKeyPath(get: (Root root) {
      final prop = get(root);
      final value = prop.value;
      if (value == null) {
        return null;
      }
      return deeper.get(value);
    }, set: (root, deep) {
      final prop = root != null ? get(root) : Presents(null);

      if (deep == null) {
        prop.value = null;
      } else {
        deeper.set(prop.value, deep);
      }

      final updatedRoot = set(root, prop);
      return updatedRoot;
    });
  }
}
