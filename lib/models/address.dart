import 'dart:convert';
import 'package:courieradmin/Helpers/itemhelper.dart';
import 'package:courieradmin/models/item.dart';

class PlaceAddress extends ItemsHelper with Item {
  String? name;
  String? phone;
  String? address;
  String? owner;
  // PlaceAddress({
  //   this.name,
  //   this.phone,
  //   this.address,
  // });

  PlaceAddress({
    this.name,
    this.phone,
    this.address,
    this.owner,
  }) : super('placeaddress') {
    super.setItem(this);
    if (ref != null) {
      super.setref(ref!);
    }
  }

  PlaceAddress.empty() : super('placeaddress') {
    super.setItem(this);
    if (ref != null) {
      super.setref(ref!);
    }
  }
  PlaceAddress copyWith({
    String? name,
    String? phone,
    String? address,
    String? owner,
  }) {
    return PlaceAddress(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      owner: owner ?? this.owner,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'owner': owner,
    };
  }

  factory PlaceAddress.fromMap(Map<String, dynamic> map) {
    return PlaceAddress(
      name: map['name'],
      phone: map['phone'],
      address: map['address'],
      owner: map['owner'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceAddress.fromJson(String source) =>
      PlaceAddress.fromMap(json.decode(source));

  @override
  String toString() =>
      'PlaceAddress(name: $name, phone: $phone, address: $address, owner: $owner)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlaceAddress &&
        other.name == name &&
        other.phone == phone &&
        other.owner == owner &&
        other.address == address;
  }

  @override
  int get hashCode =>
      name.hashCode ^ phone.hashCode ^ owner.hashCode ^ address.hashCode;

  @override
  Item empty() {
    return PlaceAddress.empty();
  }

  @override
  void fromMap(Map<String, dynamic> map) {
    name = map['name'];
    phone = map['phone'];
    address = map['address'];
    owner = map['owner'];
  }
}
