final class KeyPath<Root, Prop> {
  final Prop Function(Root) get;
  KeyPath({required this.get});

  static WritableKeyPath<A, A> identity<A>() {
    return WritableKeyPath(
        get: (a) => a,
        set: (a, b) {
          a = b;
          return a;
        });
  }
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
  final Root Function(Root, Prop) set;
  WritableKeyPath({required this.get, required this.set});
}

extension WritableKeyPathX<Root, Prop> on WritableKeyPath<Root, Prop> {
  WritableKeyPath<Root, Deeper> path<Deeper>(WritableKeyPath<Prop, Deeper> deeper) {
    return WritableKeyPath(get: (Root root) {
      final prop = get(root);
      return deeper.get(prop);
    }, set: (root, deep) {
      final prop = get(root);
      deeper.set(prop, deep);
      set(root, prop);
      return root;
    });
  }
}

Prop getProp<Root, Prop>(KeyPath<Root, Prop> keyPath, Root obj) {
  return keyPath.get(obj);
}

Root setProp<Root, Prop>(WritableKeyPath<Root, Prop> keyPath, Root obj, Prop value) {
  keyPath.set(obj, value);
  return obj;
}
