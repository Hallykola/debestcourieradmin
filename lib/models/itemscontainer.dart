import 'package:flutter/material.dart';

import 'item.dart';

class ItemsContainer extends ChangeNotifier {
  int updates = 0;
  List<String> refbucket = List.empty(growable: true);
  List<Item> container = List.empty(growable: true);
  List<Map<String, dynamic>> content = List.empty(growable: true);

  addItem(Item item, String ref) {
    refbucket.add(ref);
    container.add(item);
    content.add({'item': item, 'ref': ref});
    updates++;
    notifyListeners();
  }

  removeItem(Item item) {
    refbucket.removeAt(container.indexOf(item));
    container.remove(item);
    //content.removeAt(container.indexOf(item));

    updates++;
    notifyListeners();
  }

  clear() {
    refbucket.clear();
    container.clear();
    content.clear();
    updates = 0;
    notifyListeners();
  }

  List<Item> getItem() {
    return container;
  }

  String getItemRef(int index) {
    return refbucket[index];
  }

  List<Map<String, dynamic>> getContent() {
    return content;
  }

  String getItemRefItem(Item item) {
    return refbucket[container.indexOf(item)];
  }

  refresh() {
    notifyListeners();
  }
}
