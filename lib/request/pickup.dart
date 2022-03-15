import 'dart:async';
import 'dart:ui';

import 'package:courieradmin/models/address.dart';
import 'package:courieradmin/models/categoriescontainer.dart';
import 'package:courieradmin/models/order.dart';
import 'package:courieradmin/request/newrequest.dart';
import 'package:courieradmin/savedaddress/savedaddressbloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'locationservice.dart';

class Pickup extends StatefulWidget {
  Pickup(
      {Key? key,
      required this.press,
      required this.namecontroller,
      required this.phonecontroller,
      required this.addresscontroller,
      required this.coordinate})
      : super(key: key);
  final Function() press;
  final TextEditingController namecontroller;
  final TextEditingController phonecontroller;
  final TextEditingController addresscontroller;
  MyCoord coordinate;

  @override
  _PickupState createState() => _PickupState();
}

class _PickupState extends State<Pickup> {
  Completer<GoogleMapController> _controller = Completer();

  // ignore: prefer_const_constructors
  static final CameraPosition _ikeja = CameraPosition(
    target: LatLng(6.601838, 3.3514863),
    zoom: 14.4746,
  );

  TextEditingController searchcontroller = TextEditingController();
  TextEditingController? namecontroller;
  TextEditingController? phonecontroller;
  TextEditingController? addresscontroller;
  Function()? press;
  MyCoord? coordinate;

  Set<Marker> markers = <Marker>{};
  List<Map<String, dynamic>>? savedAddresses;
  //  = [
  //   PlaceAddress(name: "Haliru Yusuf", phone: "Home", address: "Yaba"),
  //   PlaceAddress(name: "Haliru Yusuf", phone: "Parents", address: "Ikeja"),
  //   PlaceAddress(name: "Haliru Yusuf", phone: "Work", address: "Unilag")
  // ];

  int markerCounter = 0;
  bool saveAddress = false;

  @override
  void initState() {
    super.initState();
    namecontroller = widget.namecontroller;
    phonecontroller = widget.phonecontroller;
    addresscontroller = widget.addresscontroller;
    press = widget.press;
    coordinate = widget.coordinate;
    //context.watch<SavedAddressBloc>().getMySavedAddresses(context);
  }

  @override
  Widget build(BuildContext context) {
    //savedAddresses = context.watch<SavedAddressContainer>().content;

    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          markers: markers,
          initialCameraPosition: _ikeja,
          onLongPress: (LatLng point) {
            addMarker(point, 'origin');
            usePosition(point);
          },
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        Container(
          height: 400,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Container(
                  //   decoration: const BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.all(Radius.circular(10))),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Expanded(
                  //         child: Column(
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: [
                  //             TextFormField(
                  //               controller: searchcontroller,
                  //               onChanged: (text) {},
                  //               decoration: const InputDecoration(
                  //                   hintText: 'Enter Area to move map'),
                  //               keyboardType: TextInputType.text,
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       IconButton(
                  //           onPressed: () async {
                  //             LocationService ls = LocationService();
                  //             var place = await ls
                  //                 .getPlacesAutoComplete(searchcontroller.text);
                  //             //_goToPlace(place);
                  //           },
                  //           icon: const Icon(Icons.search))
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 10),

                  // SingleChildScrollView(
                  //   child: Row(
                  //       children: List.generate(
                  //           savedAddresses!.length,
                  //           (index) => Padding(
                  //                 padding: const EdgeInsets.all(8.0),
                  //                 child: SavedAddressTile(
                  //                     title:
                  //                         savedAddresses![index]['item'].phone ??
                  //                             "",
                  //                     press: () {}),
                  //               ))),
                  // ),

                  Container(
                    //height: 0,
                    width: MediaQuery.of(context).size.width,
                    // margin:
                    //   EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: namecontroller,
                          onChanged: (text) {},
                          decoration: const InputDecoration(hintText: 'Name'),
                          keyboardType: TextInputType.text,
                        ),
                        TextFormField(
                          controller: phonecontroller,
                          onChanged: (text) {},
                          decoration: const InputDecoration(hintText: 'Phone'),
                          keyboardType: TextInputType.text,
                        ),
                        TypeAheadField(
                          textFieldConfiguration: TextFieldConfiguration(
                              controller: addresscontroller,
                              style: DefaultTextStyle.of(context)
                                  .style
                                  .copyWith(fontStyle: FontStyle.italic),
                              decoration: const InputDecoration(
                                  hintText: 'Enter Address')),
                          suggestionsCallback: (pattern) async {
                            LocationService ls = LocationService();
                            return await ls.getPlacesAutoComplete(pattern);
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              title: Text((suggestion as Map)['name']),
                            );
                          },
                          onSuggestionSelected: (suggestion) async {
                            LocationService ls = LocationService();
                            var place = await ls.getPlaceDetailsbyID(
                                (suggestion as Map)['place_id']);

                            addresscontroller!.text = (suggestion)['name'];
                            _goToPlace(place);
                          },
                        ),
                        // TextFormField(
                        //   controller: addresscontroller,
                        //   onChanged: (text) {},
                        //   decoration: const InputDecoration(
                        //       hintText: 'Enter Address'),
                        //   keyboardType: TextInputType.text,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                // Checkbox(
                                //     value: saveAddress,
                                //     onChanged: (value) {
                                //       setState(() {
                                //         saveAddress = value!;
                                //       });
                                //       if (value ?? false) {
                                //         print(value!.toString());
                                //       }
                                //     }),
                                // Text('Save Address'),
                              ],
                            ),
                            ElevatedButton(
                                onPressed: press, child: const Text('Proceed')),
                          ],
                        ),
                        Text('Long press location on map to choose address'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  addMarker(LatLng point, String name) {
    Marker amarker = Marker(
        markerId: MarkerId('markerId_$markerCounter'),
        //markerId: MarkerId('markerId'),
        infoWindow: InfoWindow(title: name),
        icon: BitmapDescriptor.defaultMarker,
        draggable: true,
        onDragEnd: (position) {
          usePosition(position);
        },
        position: point);
    markerCounter++;
    setState(() {
      markers.clear();
      markers.add(amarker);
    });
  }

  usePosition(position) async {
    Map<String, dynamic> result = await LocationService().getAddress(
        position.latitude.toString(), position.longitude.toString());
    addresscontroller!.text = result['formatted_address'];
  }

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    double latitude = place['geometry']['location']['lat'];
    double longitude = place['geometry']['location']['lng'];
    coordinate!.position = LatLng(latitude, longitude);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude, longitude), zoom: 18)));
    addMarker(LatLng(latitude, longitude), "Origin");
  }
}

class SavedAddressTile extends StatelessWidget {
  const SavedAddressTile({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);
  final String title;
  final Function() press;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: GestureDetector(
        onTap: press,
        child: Container(
          height: 34,
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 9),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.9),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
