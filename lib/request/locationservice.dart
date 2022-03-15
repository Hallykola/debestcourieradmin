import 'dart:developer';

import 'package:courieradmin/config.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocationService {
  final String key = mapKey;
  Future<String> getPlaceId(String place) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$place&inputtype=textquery&key=$key";
    http.Response response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    print(json.toString());
    print(json['candidates'][0]['place_id']);
    return json['candidates'][0]['place_id'];
  }

  Future<Iterable> getPlacesAutoComplete(String place) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$place&types=geocode&key=$key";
    http.Response response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    //print(json.toString());
    // print(json['candidates'][0]['place_id']);
    // return json['candidates'][0]['place_id'];
    List<Map<String, dynamic>> result = List.empty(growable: true);
    for (int i = 0; i < json['predictions'].length; i++) {
      print(json['predictions'][i]['description']);
      result.add({
        'name': json['predictions'][i]['description'],
        'place_id': json['predictions'][i]['place_id'],
      });
    }
    return result;
  }

  Future<Map<String, dynamic>> getPlaceDetails(String place) async {
    String placeid = await getPlaceId(place);
    String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeid&key=$key";
    http.Response response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var result = json['result'] as Map<String, dynamic>;
    print(json.toString());
    return result;
  }

  Future<Map<String, dynamic>> getPlaceDetailsbyID(String placeid) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeid&key=$key";
    http.Response response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var result = json['result'] as Map<String, dynamic>;
    print(json.toString());
    return result;
  }

  Future<Map<String, dynamic>> getAddress(String lat, String lng) async {
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$key";
    http.Response response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    print(json["results"][0]["formatted_address"].toString());
    var result = {'formatted_address': json["results"][0]["formatted_address"]};
    return result;
  }

  Future<Map<String, dynamic>> getDirections(
      String origin, String destination) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$key";
    http.Response response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var result = {
      'bounds_ne': json['routes'][0]['bounds']['northeast'],
      'bounds_sw': json['routes'][0]['bounds']['southwest'],
      'start_location': json['routes'][0]['legs'][0]['start_location'],
      'end_location': json['routes'][0]['legs'][0]['end_location'],
      'polyline': json['routes'][0]['overview_polyline']['points'],
      'distance': json['routes'][0]['legs'][0]['distance']['text'],
      'duration': json['routes'][0]['legs'][0]['duration']['text'],
      'steps': json['routes'][0]['legs'][0]['steps'],
      'polyline_decoded': PolylinePoints()
          .decodePolyline(json['routes'][0]['overview_polyline']['points']),
    };
    //print(json.toString());
    return result;
  }

  /// Print Long String
  void printLongString(String text) {
    final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern
        .allMatches(text)
        .forEach((RegExpMatch match) => print(match.group(0)));
  }
}
