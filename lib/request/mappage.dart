import 'dart:async';

import 'package:courieradmin/Widgets/myforminput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'locationservice.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  Marker kMarker = const Marker(
      markerId: MarkerId('A marker ID'),
      infoWindow: InfoWindow(title: 'An Info Window'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(37.42796133580664, -122.085749655962));

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  TextEditingController origincontroller = TextEditingController();
  TextEditingController destinationcontroller = TextEditingController();
  Set<Polyline> mypolylines = Set<Polyline>();
  Set<Marker> markers = Set<Marker>();
  int polylineCounter = 0;
  int markerCounter = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: origincontroller,
                          onChanged: (text) {},
                          decoration: const InputDecoration(
                              hintText: 'Enter Origin Address'),
                          keyboardType: TextInputType.text,
                        ),
                        TextFormField(
                          controller: destinationcontroller,
                          onChanged: (text) {},
                          decoration: const InputDecoration(
                              hintText: 'Enter Destination Address'),
                          keyboardType: TextInputType.text,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        LocationService ls = LocationService();
                        var directions = await ls.getDirections(
                            origincontroller.text, destinationcontroller.text);
                        //_goToPlace(place);
                        //print(directions.toString());
                        showDirection(directions);
                      },
                      icon: const Icon(Icons.search))
                ],
              ),
            ),
            Expanded(
              child: GoogleMap(
                mapType: MapType.normal,
                markers: markers,
                polylines: mypolylines,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Text('To the lake!'),
          icon: Icon(Icons.directions_boat),
        ),
      ),
    );
  }

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    double latitude = place['geometry']['location']['lat'];
    double longitude = place['geometry']['location']['lng'];
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude, longitude), zoom: 18)));
  }

  void showDirection(Map<String, dynamic> details) async {
    LatLngBounds bounds = LatLngBounds(
        southwest:
            LatLng(details['bounds_sw']['lat'], details['bounds_sw']['lng']),
        northeast:
            LatLng(details['bounds_ne']['lat'], details['bounds_ne']['lng']));
    final GoogleMapController controller = await _controller.future;
    LatLng start = LatLng(
        details['start_location']['lat'], details['start_location']['lng']);
    LatLng end = LatLng(
        details['end_location']['lat'], details['end_location']['lng']);
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: start,
    )));
    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 10));
    addMarker(start);
    addMarker(end);
    setState(() {
      setPolyLines(details['polyline_decoded']);
      print(details['polyline_decoded'].toList.toString());
    });
  }

  addMarker(LatLng point) {
    Marker amarker = Marker(
        markerId: MarkerId('markerId_$markerCounter'),
        icon: BitmapDescriptor.defaultMarker,
        position: point);
    markerCounter++;
    setState(() {
      markers.add(amarker);
    });
  }

  setPolyLines(List<PointLatLng> points) {
    final String polylineId = 'polyline_$polylineCounter';
    polylineCounter++;
    mypolylines.add(Polyline(
      polylineId: PolylineId(polylineId),
      width: 2,
      color: Colors.blueAccent,
      points: points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList(),
    ));
  }
}
