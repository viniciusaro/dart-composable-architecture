final class Item {
  final int id;
  final String name;
  const Item({required this.id, required this.name});

  @override
  String toString() {
    return "Item($name)";
  }

  @override
  int get hashCode => id.hashCode ^ 31;

  @override
  bool operator ==(Object other) {
    return other is Item && other.id == id;
  }
}
