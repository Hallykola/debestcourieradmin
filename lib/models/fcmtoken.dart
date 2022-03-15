import 'package:courieradmin/models/item.dart';
import 'package:courieradmin/Helpers/itemhelper.dart';

class Fcmtoken extends ItemsHelper with Item {
  String? token;
  String? uid;
  Fcmtoken() : super('fcmtokens') {
    super.setItem(this);
    if (ref != null) {
      super.setref(ref!);
    }
  }


  Fcmtoken.empty() : super('fcmtokens') {
    super.setItem(this);
    if (ref != null) {
      super.setref(ref!);
    }
  }

  @override
  Item empty() {
    return Fcmtoken.empty();
  }

  @override
  void fromMap(Map<String, dynamic> map) {
    token = map['token'] ?? '';
    uid = map['uid'] ?? '';
  }

// @override
//   addItem() async{
//     print('i want add now');
//     var result = await firestore.doc(baseref!).set(itema!.toMap());
//     // not necessary but useful for feedback
//     print('i want add');
//     Map<String, dynamic>? endresult;
//     await firestore.doc(baseref!).get().asStream().forEach((element) {
//       endresult = element.data();
//       ref = element.reference.toString();
//       print('i fit add');
//     });
   

 // }
 
  @override
  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'uid': uid,
    };
  }
}
