import 'dart:convert';

import 'package:courieradmin/Helpers/itemhelper.dart';
import 'package:courieradmin/models/item.dart';

class Order extends ItemsHelper with Item {
  String? pickupaddress;
  String? dropoffaddress;
  String? pickupaddresslat;
  String? dropoffaddresslat;
  String? pickupaddresslng;
  String? dropoffaddresslng;
  String? packagetype;
  String? packageheight;
  String? packagewidth;
  String? packagelength;
  String? packagefrangible;
  String? packageweight;
  String? packagedetail;
  String? sendername;
  String? senderphone;
  String? receiverphone;
  String? receivername;
  String? estimateddistance;
  String? deliverymode;
  String? costofdelivery;
  String? paymentmode;
  String? paymentstatus;
  String? currentlocation;
  String? locationhistory;
  String? ridername;
  String? riderphone;
  String? rideruid;
  String? senderuid;
  String? senderpasscode;
  String? riderpasscode;
  String? receiveruid;
  String? ordertime;
  int? ordertimeepoch;
  String? deliverystatus;

  Order() : super('orders') {
    super.setItem(this);
    if (ref != null) {
      super.setref(ref!);
    }
  }

  Order.empty() : super('orders') {
    super.setItem(this);
    if (ref != null) {
      super.setref(ref!);
    }
  }

  @override
  Item empty() {
    return Order.empty();
  }

  Order.withParams({
    this.pickupaddress,
    this.dropoffaddress,
    this.packagetype,
    this.packageheight,
    this.packagewidth,
    this.packagelength,
    this.packagefrangible,
    this.packageweight,
    this.packagedetail,
    this.sendername,
    this.senderphone,
    this.receiverphone,
    this.receivername,
    this.estimateddistance,
    this.deliverymode,
    this.costofdelivery,
    this.paymentmode,
    this.paymentstatus,
    this.currentlocation,
    this.locationhistory,
    this.ridername,
    this.riderphone,
    this.rideruid,
    this.senderuid,
    this.riderpasscode,
    this.receiveruid,
    this.ordertime,
    this.deliverystatus,
    this.pickupaddresslat,
    this.dropoffaddresslat,
    this.pickupaddresslng,
    this.dropoffaddresslng,
    this.senderpasscode,
    this.ordertimeepoch,
  }) : super('orders');

  Order copyWith({
    String? pickupaddress,
    String? dropoffaddress,
    String? packagetype,
    String? packageheight,
    String? packagewidth,
    String? packagelength,
    String? packagefrangible,
    String? packageweight,
    String? packagedetail,
    String? sendername,
    String? senderphone,
    String? receiverphone,
    String? receivername,
    String? estimateddistance,
    String? deliverymode,
    String? costofdelivery,
    String? paymentmode,
    String? paymentstatus,
    String? currentlocation,
    String? locationhistory,
    String? ridername,
    String? riderphone,
    String? rideruid,
    String? senderuid,
    String? receiveruid,
    String? ordertime,
    String? deliverystatus,
    String? pickupaddresslat,
    String? dropoffaddresslat,
    String? pickupaddresslng,
    String? dropoffaddresslng,
    String? senderpasscode,
    String? riderpasscode,
    int? ordertimeepoch,
  }) {
    return Order.withParams(
      pickupaddress: pickupaddress ?? this.pickupaddress,
      dropoffaddress: dropoffaddress ?? this.dropoffaddress,
      packagetype: packagetype ?? this.packagetype,
      packageheight: packageheight ?? this.packageheight,
      packagewidth: packagewidth ?? this.packagewidth,
      packagelength: packagelength ?? this.packagelength,
      packagefrangible: packagefrangible ?? this.packagefrangible,
      packageweight: packageweight ?? this.packageweight,
      packagedetail: packagedetail ?? this.packagedetail,
      sendername: sendername ?? this.sendername,
      senderuid: senderuid ?? this.senderuid,
      senderphone: senderphone ?? this.senderphone,
      receiverphone: receiverphone ?? this.receiverphone,
      receivername: receivername ?? this.receivername,
      estimateddistance: estimateddistance ?? this.estimateddistance,
      deliverymode: deliverymode ?? this.deliverymode,
      costofdelivery: costofdelivery ?? this.costofdelivery,
      paymentmode: paymentmode ?? this.paymentmode,
      paymentstatus: paymentstatus ?? this.paymentstatus,
      currentlocation: currentlocation ?? this.currentlocation,
      locationhistory: locationhistory ?? this.locationhistory,
      ridername: ridername ?? this.ridername,
      riderphone: riderphone ?? this.riderphone,
      rideruid: rideruid ?? this.rideruid,
      senderpasscode: senderpasscode ?? this.senderpasscode,
      riderpasscode: riderpasscode ?? this.riderpasscode,
      receiveruid: receiveruid ?? this.receiveruid,
      ordertime: ordertime ?? this.ordertime,
      ordertimeepoch: ordertimeepoch ?? this.ordertimeepoch,
      deliverystatus: deliverystatus ?? this.deliverystatus,
      pickupaddresslat: pickupaddresslat ?? this.pickupaddresslat,
      dropoffaddresslat: dropoffaddresslat ?? this.dropoffaddresslat,
      pickupaddresslng: pickupaddresslng ?? this.pickupaddresslng,
      dropoffaddresslng: dropoffaddresslng ?? this.dropoffaddresslng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pickupaddress': pickupaddress,
      'dropoffaddress': dropoffaddress,
      'packagetype': packagetype,
      'packageheight': packageheight,
      'packagewidth': packagewidth,
      'packagelength': packagelength,
      'packagefrangible': packagefrangible,
      'packageweight': packageweight,
      'packagedetail': packagedetail,
      'sendername': sendername,
      'senderphone': senderphone,
      'receiverphone': receiverphone,
      'receivername': receivername,
      'estimateddistance': estimateddistance,
      'deliverymode': deliverymode,
      'costofdelivery': costofdelivery,
      'paymentmode': paymentmode,
      'paymentstatus': paymentstatus,
      'currentlocation': currentlocation,
      'locationhistory': locationhistory,
      'ridername': ridername,
      'riderphone': riderphone,
      'rideruid': rideruid,
      'senderuid': senderuid,
      'senderpasscode': senderpasscode,
      'riderpasscode': riderpasscode,
      'receiveruid': receiveruid,
      'ordertime': ordertime,
      'ordertimeepoch': ordertimeepoch,
      'deliverystatus': deliverystatus,
      'dropoffaddresslat': dropoffaddresslat,
      'pickupaddresslat': pickupaddresslat,
      'pickupaddresslng': pickupaddresslng,
      'dropoffaddresslng': dropoffaddresslng,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order.withParams(
      pickupaddress: map['pickupaddress'] ?? "",
      dropoffaddress: map['dropoffaddress'] ?? "",
      packagetype: map['packagetype'] ?? "",
      packageheight: map['packageheight'] ?? "",
      packagewidth: map['packagewidth'] ?? "",
      packagelength: map['packagelength'] ?? "",
      packagefrangible: map['packagefrangible'] ?? "",
      packageweight: map['packageweight'] ?? "",
      packagedetail: map['packagedetail'] ?? "",
      sendername: map['sendername'] ?? "",
      senderphone: map['senderphone'] ?? "",
      receiverphone: map['receiverphone'] ?? "",
      receivername: map['receivername'] ?? "",
      estimateddistance: map['estimateddistance'] ?? "",
      deliverymode: map['deliverymode'] ?? "",
      costofdelivery: map['costofdelivery'] ?? "",
      paymentmode: map['paymentmode'] ?? "",
      paymentstatus: map['paymentstatus'] ?? "",
      currentlocation: map['currentlocation'] ?? "",
      locationhistory: map['locationhistory'] ?? "",
      ridername: map['ridername'] ?? "",
      riderphone: map['riderphone'] ?? "",
      rideruid: map['rideruid'] ?? "",
      receiveruid: map['receiveruid'] ?? "",
      senderuid: map['senderuid'] ?? "",
      senderpasscode: map['senderpasscode'] ?? "",
      riderpasscode: map['riderpasscode'] ?? "",
      ordertime: map['ordertime'] ?? "",
      ordertimeepoch: map['ordertimeepoch'] ?? 0,
      deliverystatus: map['deliverystatus'] ?? "",
      pickupaddresslat: map['pickupaddresslat'] ?? "",
      dropoffaddresslat: map['dropoffaddresslat'] ?? "",
      pickupaddresslng: map['pickupaddresslng'] ?? "",
      dropoffaddresslng: map['dropoffaddresslng'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(pickupaddress: $pickupaddress, dropoffaddress: $dropoffaddress, packagetype: $packagetype, packageheight: $packageheight, packagewidth: $packagewidth, packagelength: $packagelength, packagefrangible: $packagefrangible, packageweight: $packageweight, packagedetail: $packagedetail, sendername: $sendername, senderphone: $senderphone, receiverphone: $receiverphone, receivername: $receivername, estimateddistance: $estimateddistance, deliverymode: $deliverymode, costofdelivery: $costofdelivery, paymentmode: $paymentmode, paymentstatus: $paymentstatus, currentlocation: $currentlocation, locationhistory: $locationhistory, ridername: $ridername, riderphone: $riderphone, rideruid: $rideruid, receiveruid: $receiveruid, senderuid: $senderuid,pickupaddresslat: $pickupaddresslat,dropoffaddresslat: $dropoffaddresslat,pickupaddresslng: $pickupaddresslng,dropoffaddresslng: $dropoffaddresslng,ordertime: $ordertime,ordertimeepoch: $ordertimeepoch,senderpasscode: $senderpasscode,riderpasscode: $riderpasscode,deliverystatus: $deliverystatus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.pickupaddress == pickupaddress &&
        other.dropoffaddress == dropoffaddress &&
        other.packagetype == packagetype &&
        other.packageheight == packageheight &&
        other.packagewidth == packagewidth &&
        other.packagelength == packagelength &&
        other.packagefrangible == packagefrangible &&
        other.packageweight == packageweight &&
        other.packagedetail == packagedetail &&
        other.sendername == sendername &&
        other.senderphone == senderphone &&
        other.receiverphone == receiverphone &&
        other.receivername == receivername &&
        other.estimateddistance == estimateddistance &&
        other.deliverymode == deliverymode &&
        other.costofdelivery == costofdelivery &&
        other.paymentmode == paymentmode &&
        other.paymentstatus == paymentstatus &&
        other.currentlocation == currentlocation &&
        other.locationhistory == locationhistory &&
        other.ridername == ridername &&
        other.rideruid == rideruid &&
        other.senderuid == senderuid &&
        other.senderpasscode == senderpasscode &&
        other.riderpasscode == riderpasscode &&
        other.receiveruid == receiveruid &&
        other.ordertime == ordertime &&
        other.ordertimeepoch == ordertimeepoch &&
        other.deliverystatus == deliverystatus &&
        other.dropoffaddresslat == dropoffaddresslat &&
        other.pickupaddresslat == pickupaddresslat &&
        other.pickupaddresslng == pickupaddresslng &&
        other.dropoffaddresslng == dropoffaddresslng &&
        other.riderphone == riderphone;
  }

  @override
  int get hashCode {
    return pickupaddress.hashCode ^
        dropoffaddress.hashCode ^
        packagetype.hashCode ^
        packageheight.hashCode ^
        packagewidth.hashCode ^
        packagelength.hashCode ^
        packagefrangible.hashCode ^
        packageweight.hashCode ^
        packagedetail.hashCode ^
        sendername.hashCode ^
        senderphone.hashCode ^
        receiverphone.hashCode ^
        receivername.hashCode ^
        estimateddistance.hashCode ^
        deliverymode.hashCode ^
        costofdelivery.hashCode ^
        paymentmode.hashCode ^
        paymentstatus.hashCode ^
        currentlocation.hashCode ^
        locationhistory.hashCode ^
        ridername.hashCode ^
        rideruid.hashCode ^
        senderuid.hashCode ^
        senderpasscode.hashCode ^
        riderpasscode.hashCode ^
        receiveruid.hashCode ^
        ordertime.hashCode ^
        ordertimeepoch.hashCode ^
        deliverystatus.hashCode ^
        dropoffaddresslat.hashCode ^
        pickupaddresslat.hashCode ^
        pickupaddresslng.hashCode ^
        dropoffaddresslng.hashCode ^
        riderphone.hashCode;
  }

  @override
  void fromMap(Map<String, dynamic> map) {
    pickupaddress = map['pickupaddress'] ?? "";
    dropoffaddress = map['dropoffaddress'] ?? "";
    packagetype = map['packagetype'] ?? "";
    packageheight = map['packageheight'] ?? "";
    packagewidth = map['packagewidth'] ?? "";
    packagelength = map['packagelength'] ?? "";
    packagefrangible = map['packagefrangible'] ?? "";
    packageweight = map['packageweight'] ?? "";
    packagedetail = map['packagedetail'] ?? "";
    sendername = map['sendername'] ?? "";
    senderphone = map['senderphone'] ?? "";
    receiverphone = map['receiverphone'] ?? "";
    receivername = map['receivername'] ?? "";
    estimateddistance = map['estimateddistance'] ?? "";
    deliverymode = map['deliverymode'] ?? "";
    costofdelivery = map['costofdelivery'] ?? "";
    paymentmode = map['paymentmode'] ?? "";
    paymentstatus = map['paymentstatus'] ?? "";
    currentlocation = map['currentlocation'] ?? "";
    locationhistory = map['locationhistory'] ?? "";
    ridername = map['ridername'] ?? "";
    riderphone = map['riderphone'] ?? "";
    rideruid = map['rideruid'] ?? "";
    senderuid = map['senderuid'] ?? "";
    senderpasscode = map['senderpasscode'] ?? "";
    riderpasscode = map['riderpasscode'] ?? "";
    receiveruid = map['receiveruid'] ?? "";
    ordertime = map['ordertime'] ?? "";
    ordertimeepoch = map['ordertimeepoch'] ?? "";
    deliverystatus = map['deliverystatus'] ?? "";
    dropoffaddresslat = map['dropoffaddresslat'] ?? "";
    pickupaddresslat = map['pickupaddresslat'] ?? "";
    pickupaddresslng = map['pickupaddresslng'] ?? "";
    dropoffaddresslng = map['dropoffaddresslng'] ?? "";
  }
}
