abstract class Item {
  String? ref;
  Item empty();
  Map<String, dynamic> toMap();
  void fromMap(Map<String, dynamic> map);
}
