import 'package:courieradmin/Helpers/itemhelper.dart';
import 'package:courieradmin/models/categoriescontainer.dart';
import 'package:courieradmin/models/item.dart';
import 'package:courieradmin/models/itemscontainer.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Profile extends ItemsHelper with Item {
  String name = "";
  String address = "";
  String phonenumber = "";
  String email = "";
  String platenumber = "";
  bool? active;
  String uid = "";
  String profilepicurl = "";
  LatLng? currentlocation;
  double lat = 34;
  double lng = 45;
  String geohash = "";
  String fcmtoken = "";

  Profile() : super('profiles') {
    super.setItem(this);
    if (ref != null) {
      super.setref(ref!);
    }
  }

  Profile.empty() : super('profiles') {
    super.setItem(this);
    if (ref != null) {
      super.setref(ref!);
    }
  }

  @override
  Item empty() {
    return Profile.empty();
  }

  @override
  void fromMap(Map<String, dynamic> map) {
    name = map['name'];
    address = map['address'];
    uid = map['uid'] ?? '';
    profilepicurl = map['profilepicurl'] ?? '';
    phonenumber = map['phonenumber'] ?? '';
    email = map['email'] ?? '';
    platenumber = map['platenumber'] ?? '';
    active = map['active'] ?? true;
    // currentlocation = map['currentlocation'] ?? '';

    currentlocation = (map['position'] != null)
        ? LatLng(map['position']['geopoint'].latitude,
            map['position']['geopoint'].longitude)
        : const LatLng(34.6, 45.8);
    lat = map['lat'] ?? 45;
    lng = map['lng'] ?? 34;
    geohash = map['geohash'] ?? '';
    fcmtoken = map['fcmtoken'] ?? '';
  }

  @override
  Map<String, dynamic> toMap() {
    GeoFirePoint myLocation = Geoflutterfire().point(
        latitude: currentlocation!.latitude,
        longitude: currentlocation!.longitude);

    return {
      'name': name,
      'address': address,
      'uid': uid,
      'profilepicurl': profilepicurl,
      'phonenumber': phonenumber,
      'email': email,
      'platenumber': platenumber,
      'active': active,
      //'currentlocation': currentlocation,
      'currentlocation': myLocation.data,
      'lat': myLocation.latitude,
      'lng': myLocation.longitude,
      'geohash': myLocation.hash,
      'fcmtoken': fcmtoken,
    };
  }
}
