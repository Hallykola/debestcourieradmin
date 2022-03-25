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

  getItemsBy(ItemsContainer itemsContainer,orderby) async {
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
    firestore.collection(baseref!).orderBy(orderby).snapshots().forEach((element) {
      itemsContainer.clear();
      element.docs.forEach((element) {
        Item item = type.empty();
        item.fromMap(element.data());
        item.ref = element.reference.path.toString();

        itemsContainer.addItem(item, element.reference.path.toString());
      });
    });
  }


getXItems(ItemsContainer itemsContainer,int limit,orderby) async {
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
    firestore.collection(baseref!).orderBy(orderby).limit(limit).snapshots().forEach((element) {
      itemsContainer.clear();
      element.docs.forEach((element) {
        Item item = type.empty();
        item.fromMap(element.data());
        item.ref = element.reference.path.toString();

        itemsContainer.addItem(item, element.reference.path.toString());
      });
    });
  }

getNextXItems(ItemsContainer itemsContainer,int limit, List<Object> after, Object orderby) async {
    itemsContainer.clear();
    
    Item type = itema!;
    firestore.collection(baseref!).orderBy(orderby).startAfter(after).limit(limit).snapshots().forEach((element) {
      itemsContainer.clear();
      element.docs.forEach((element) {
        Item item = type.empty();
        item.fromMap(element.data());
        item.ref = element.reference.path.toString();

        itemsContainer.addItem(item, element.reference.path.toString());
      });
    });
  }getPrevXItems(ItemsContainer itemsContainer,int limit,List<Object> before, Object orderby) async {
    itemsContainer.clear();

    Item type = itema!;
    firestore.collection(baseref!).orderBy(orderby).endAt(before).limit(limit).snapshots().forEach((element) {
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

 getItemsWhereBy(ItemsContainer itemsContainer, name, value, orderby) async {
    itemsContainer.clear();

    Item type = itema!;
    firestore
        .collection(baseref!)
        .where('$name', isEqualTo: '$value')
        .orderBy(orderby)
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
