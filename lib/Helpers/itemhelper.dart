import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courieradmin/models/item.dart';
import 'package:courieradmin/models/itemscontainer.dart';
import 'package:courieradmin/models/response.dart';

class ItemsHelper {
  String? baseref;
  Item? itema;
  String? ref;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  ItemsHelper(this.baseref);

  setItem(Item item) {
    itema = item;
  }

  setref(String refa) {
    ref = refa;
  }

  addItem() async {
    print('i want add now');
    var result = await firestore.collection(baseref!).add(itema!.toMap());
    // not necessary but useful for feedback
    print('i want add');
    Response response = Response();
    Map<String, dynamic>? endresult;
    result.get().asStream().forEach((element) {
      endresult = element.data();
      ref = element.reference.toString();
      print('i fit add');
    });
    if (endresult != null) {
      response.setData(endresult);
      response.setType(status.success);
      print('i fit add');
    } else {
      response.setType(status.fail);
    }
    return response;
  }

  getItems(ItemsContainer itemsContainer) async {
    itemsContainer.clear();
    // QuerySnapshot<Map<String, dynamic>> items =
    //     await firestore.collection(baseref!).get();

    // items.docs.forEach((element) {
    //   Item item = type.empty();
    //   item.fromMap(element.data());
    //   itemsContainer.addItem(item, element.reference.path.toString());
    // });
    // print(itemsContainer.refbucket.toString());
    Item type = itema!;
    firestore.collection(baseref!).snapshots().forEach((element) {
      itemsContainer.clear();
      element.docs.forEach((element) {
        Item item = type.empty();
        item.fromMap(element.data());
        item.ref = element.reference.path.toString();

        itemsContainer.addItem(item, element.reference.path.toString());
      });
    });
  }

  getItemsWhere(ItemsContainer itemsContainer, name, value) async {
    itemsContainer.clear();

    Item type = itema!;
    firestore
        .collection(baseref!)
        .where('$name', isEqualTo: '$value')
        .snapshots()
        .forEach((element) {
      itemsContainer.clear();
      element.docs.forEach((element) {
        Item item = type.empty();
        print(element.data().toString());
        item.fromMap(element.data());

        item.ref = element.reference.path.toString();
        itemsContainer.addItem(item, element.reference.path.toString());
      });
    });
  }

  Future<int> getItemsCountWhere(name, value) async {
    int number = 0;
    await firestore
        .collection(baseref!)
        .where('$name', isEqualTo: '$value')
        .get()
        .then((value) {
      number = value.docs.length;
    });
    return number;
  }

  removeItem() {
    firestore.doc(ref!).delete();
  }

  updateItem() {
    firestore.doc(ref!).set(itema!.toMap());
  }
}
