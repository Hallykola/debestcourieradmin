import 'package:courieradmin/Helpers/itemhelper.dart';
import 'package:courieradmin/models/item.dart';

class Payment extends ItemsHelper with Item {
  String reference = " ";
  String paymentfororder = " ";
  String paymenttime = " ";
  double amount = 0;
  String details = " ";
  String owneruid = " ";
  String distance = "";
  String paymentstatus = "";
  String paymentmode = "";

  Payment() : super('payments') {
    super.setItem(this);
    if (ref != null) {
      super.setref(ref!);
    }
  }

  Payment.empty() : super('payments') {
    super.setItem(this);
    if (ref != null) {
      super.setref(ref!);
    }
  }

  @override
  Item empty() {
    return Payment.empty();
  }

  @override
  void fromMap(Map<String, dynamic> map) {
    reference = map['reference'] ?? '';
    paymentfororder = map['Paymentfororder'] ?? '';
    paymenttime = map['paymenttime'] ?? '';
    amount = map['amount'] ?? 0;
    details = map['details'] ?? '';
    owneruid = map['owneruid'] ?? '';
    distance = map['distance'] ?? '';
    paymentstatus = map['paymentstatus'] ?? '';
    paymentmode = map['paymentmode'] ?? '';
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'reference': reference,
      'paymentfororder': paymentfororder,
      'paymenttime': paymenttime,
      'amount': amount,
      'details': details,
      'owneruid': owneruid,
      'distance': distance,
      'paymentstatus': paymentstatus,
      'paymentmode': paymentmode
    };
  }
}
