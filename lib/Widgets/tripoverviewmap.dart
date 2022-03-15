import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:courieradmin/models/categoriescontainer.dart';
import 'package:courieradmin/models/profile.dart';
import 'package:courieradmin/signin/myauth.dart';
import 'package:provider/provider.dart';
import 'package:courieradmin/Widgets/utilbloc.dart';
import 'package:courieradmin/constants.dart';
import 'package:courieradmin/models/order.dart';
import 'package:courieradmin/request/locationservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TripOverviewMap extends StatefulWidget {
  final Order order;
  TripOverviewMap({Key? key, required this.order}) : super(key: key);

  @override
  State<TripOverviewMap> createState() => _TripOverviewMapState();
}

class _TripOverviewMapState extends State<TripOverviewMap> {
  Set<Marker> markers = <Marker>{};
  Set<Polyline> mypolylines = <Polyline>{};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  String distance = 'loading';

  Completer<GoogleMapController> _controller = Completer();
  Order? order;
  // ignore: prefer_const_constructors
  static final CameraPosition _ikeja = CameraPosition(
    target: LatLng(6.601838, 3.3514863),
    zoom: 14.4746,
  );
  Profile? otherProfile;

  @override
  void initState() {
    super.initState();
    order = widget.order;
    if (order!.pickupaddresslat != null && order!.pickupaddresslng != null) {
      markers.add(Marker(
          markerId: MarkerId('origin'),
          position: LatLng(double.parse(order!.pickupaddresslat as String),
              double.parse(order!.pickupaddresslng as String))));
      getDirections();
      getUsers();
    }

    if (order!.dropoffaddresslat != null && order!.dropoffaddresslng != null) {
      markers.add(Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          markerId: MarkerId('destination'),
          position: LatLng(double.parse(order!.dropoffaddresslat as String),
              double.parse(order!.dropoffaddresslng as String))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.65,
              margin: EdgeInsets.only(
                top: 4,
              ),
              child: Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    markers: markers,
                    initialCameraPosition: _ikeja,
                    onLongPress: (LatLng point) {
                      // addMarker(point, 'origin');
                      // usePosition(point);
                    },
                    polylines:
                        mypolylines, //Set<Polyline>.of(polylines.values),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                  Container(
                      height: 40,
                      margin:
                          const EdgeInsets.only(top: 40, left: 20, right: 20),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.amberAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Distance is $distance ',
                            style: TextStyle(color: Colors.red, fontSize: 20)),
                      )),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  SenderTile(order: order),
                  Divider(
                    height: 4,
                    thickness: 3,
                  ),
                  Usertile(order: order),
                  Divider(
                    height: 4,
                    thickness: 3,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // setDeliveryStatus(DeliveryStatus.PICKED, order!,
                        //     data: "5");
                        showPickerArray(context ,order!);
                      },
                      child: ListTile(
                        leading: Icon(Icons.add_box),
                        title: Text('Delivery Status: '),
                        subtitle: Text(order!.deliverystatus ?? ""),
                      )),
                  Divider(
                    height: 4,
                    thickness: 3,
                  ),
                  ListTile(
                    leading: Icon(Icons.location_pin),
                    title: Text(order!.sendername ?? ""),
                    subtitle: Text(order!.pickupaddress ?? ""),
                  ),
                  Divider(
                    height: 4,
                    thickness: 3,
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_upward_sharp),
                    title: Text(order!.receivername ?? ""),
                    subtitle: Text(order!.dropoffaddress ?? ""),
                  ),
                  Divider(
                    height: 4,
                    thickness: 3,
                  ),
                  ListTile(
                      leading: Icon(Icons.add_box),
                      title: Text('Package Type: ${order!.packagetype ?? ""}'),
                      subtitle: Text(
                          'Length(${order!.packagelength ?? 0}) x Width(${order!.packagewidth ?? 0}) x Height(${order!.packageheight ?? 0})'),
                      trailing: Text('Weight: ${order!.packageweight ?? 0}kg')),
                  Divider(
                    height: 4,
                    thickness: 3,
                  ),
                  ListTile(
                      leading: Icon(Icons.payment),
                      title: Text('Payment Mode: ${order!.paymentmode ?? ""}'),
                      subtitle: Text('Status ${order!.paymentstatus ?? ""}'),
                      trailing: Text('NGN${order!.costofdelivery ?? 0}')),
                  Divider(
                    height: 4,
                    thickness: 3,
                  ),
                  ListTile(
                    leading: Icon(Icons.note),
                    title: Text('Package Note'),
                    subtitle: Text('${order!.packagedetail ?? ""}'),
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  getDirections() async {
    LocationService ls = LocationService();
    var directions = await ls.getDirections(
        "${order!.pickupaddresslat},${order!.pickupaddresslng}",
        "${order!.dropoffaddresslat},${order!.dropoffaddresslng}");
    var result = directions['polyline_decoded'];

    if (result.isNotEmpty) {
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    setState(() {
      mypolylines.add(Polyline(
        polylineId: PolylineId('yay'),
        width: 2,
        color: Colors.red,
        points: polylineCoordinates,
      ));
      distance = directions['distance'];
    });
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
            southwest: LatLng(
                directions['bounds_sw']['lat'], directions['bounds_sw']['lng']),
            northeast: LatLng(directions['bounds_ne']['lat'],
                directions['bounds_ne']['lng'])),
        22));
  }

  getUsers() async {
    UtilBloc utilbloc = Provider.of<UtilBloc>(context, listen: false);
    await utilbloc.getProfile(order!.senderuid, context);
  }

  showPickerArray(BuildContext context, Order order) {
    const PickerData2 = '''
[
    [
        "PICKUP ASSIGNED",
        "PICK UP IN ",
        "PICKED",
        "DELIVERY IN",
        "DELIVERED"
    ],
    [
        "",
        "5 MINS",
        "20 MINS",
        "1 HR",
        "2 HRS",
        "6 HRS",
        "1 DAY",
        "3 DAYS",
        "7 DAY"
    ]   
]
    ''';
    Picker(
        adapter: PickerDataAdapter<String>(
            pickerdata: JsonDecoder().convert(PickerData2), isArray: true),
        hideHeader: true,
        title: Text("Set New Delivery Status"),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
          setNewStatus(
            order,picker.getSelectedValues()[0],data: picker.getSelectedValues()[1]
          );
        }).showDialog(context);
  }

  setNewStatus(Order order, String status, {String data = ""}) {
    order.deliverystatus = '$status $data';
    order.updateItem();
    setState(() {});
    print('$status $data');
  }

  setDeliveryStatus(DeliveryStatus status, Order order, {String data = ""}) {
    switch (status) {
      case DeliveryStatus.PICKUPASSIGNED:
        order.deliverystatus = 'PICKUP ASSIGNED';
        order.updateItem();
        setState(() {});
        print('pickup assigned');
        break;
      case DeliveryStatus.PICKUPINX:
        order.deliverystatus = 'PICKUP in $data minutes';
        order.updateItem();
        break;
      case DeliveryStatus.PICKED:
        order.deliverystatus = 'PICKED';
        order.updateItem();
        setState(() {});
        print('package pickuped');

        break;
      case DeliveryStatus.DELIVERYINX:
        order.deliverystatus = 'DELIVERY IN $data minutes';
        order.updateItem();
        break;
      case DeliveryStatus.DELIVERED:
        order.deliverystatus = 'DELIVERED';
        order.updateItem();
        break;

      default:
    }
  }
}

enum DeliveryStatus {
  PICKUPASSIGNED,
  PICKUPINX,
  PICKED,
  DELIVERYINX,
  DELIVERED
}

class SenderTile extends StatelessWidget {
  const SenderTile({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order? order;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 40,
        backgroundImage: (context
                .watch<OtherProfilesContainer>()
                .content
                .isEmpty)
            ? NetworkImage(
                'https://firebasestorage.googleapis.com/v0/b/debest-courier.appspot.com/o/photo-1494790108377-be9c29b29330%20(2).jpg?alt=media&token=71ebb4c1-7fa1-4503-9bf8-ee0bd1bfd9b2')
            : NetworkImage(context
                .watch<OtherProfilesContainer>()
                .content[0]['item']
                .profilepicurl),
      ),
      title: Text('${order!.sendername}'),
      subtitle: Text('${order!.senderphone}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.message)),
        ],
      ),
    );
  }
}

class Usertile extends StatelessWidget {
  const Usertile({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order? order;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage(context
            .watch<ProfilesContainer>()
            .content[0]['item']
            .profilepicurl),
      ),
      title: Text('${order!.ridername}'),
      subtitle: Text('${order!.riderphone}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.message)),
        ],
      ),
    );
  }
}
