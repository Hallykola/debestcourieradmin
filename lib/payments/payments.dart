import 'package:courieradmin/account/account.dart';
import 'package:courieradmin/constants.dart';
import 'package:courieradmin/main.dart';
import 'package:courieradmin/models/categoriescontainer.dart';
import 'package:courieradmin/models/fcmtoken.dart';
import 'package:courieradmin/models/profile.dart';
import 'package:courieradmin/signin/myauth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:courieradmin/Widgets/pagedesign.dart';

class Payments extends StatefulWidget {
  Payments({Key? key}) : super(key: key);

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  late ProfilesContainer myprofilecontainer;
  bool sharelocation = false;
  @override
  void initState() {
    super.initState();
    myprofilecontainer = Provider.of<ProfilesContainer>(context, listen: false);
    setLocationnUpdate(context);
    saveFCMToken();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double headerHeight = size.height * 0.2;
    PaymentsContainer paymentscontainer = context.watch<PaymentsContainer>();
    List<Map<String, dynamic>> payments = paymentscontainer.content;
    return Scaffold(
      bottomNavigationBar: const BottomNav(
        activeTab: 0,
      ),
      backgroundColor: kPrimaryColor,
      body: PageDesign(
          sideChild: Container(),
          headerHeight: headerHeight,
          header: SizedBox(
              height: headerHeight,
              child: Center(
                  child: Text('My Earnings',
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: Colors.white)))),
          content: Container(
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(35))),
            child: Container(
              margin: const EdgeInsets.only(left: 25, top: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Transactions',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  (payments.isEmpty)
                      ? Container(
                          margin: const EdgeInsets.all(10),
                          child: const Text('No payments yet'))
                      : Container(),
                  ...List.generate(
                      payments.length,
                      (index) => Container(
                          height: MediaQuery.of(context).size.height * 0.18,
                          width: MediaQuery.of(context).size.width * 0.9,
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(2, 4),
                                  color: kPrimaryColor,
                                  blurRadius: 5)
                            ],
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: SvgPicture.asset(
                                    'assets/icons/box.svg',
                                    height: 110,
                                  )),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(payments[index]['item'].details, style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color.fromARGB(255, 9, 161, 238)),),
                                   Text('Description', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.blueGrey))
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(payments[index]['item']
                                        .amount
                                        .toString(), style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color.fromARGB(255, 134, 123, 238)),),
                                    Text("Amount", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.blueGrey),),
                                  ],
                                ),
                              ),
                              // Expanded(
                              //   flex: 1,
                              //   child: Text(
                              //       payments[index]['item'].paymentfororder),
                              // )
                            ],
                          )))
                ],
              ),
            ),
          ),
          lastChild: Container(),
          fixedLastChild: Container()),
    );
  }

  setLocationnUpdate(context) async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    location.onLocationChanged.listen((LocationData currentLocation) {
      // Use current location
      setLocation(context, currentLocation);
    });
    location.enableBackgroundMode(enable: true);
    setLocation(context, _locationData);
  }

  setLocation(context, _locationData) {
    try {
      if (myprofilecontainer.content.isNotEmpty && sharelocation) {
        Profile myprofile = myprofilecontainer.content[0]['item'];
        myprofile.currentlocation =
            LatLng(_locationData.latitude!, _locationData.longitude!);
        myprofile.updateItem();
        print('i dey save location o!');
      }
    } catch (e) {
      print('An error occured: $e');
    }
  }

  saveFCMToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    //
    // Profile userprofile = myprofilecontainer.content[0]['item'];
    // userprofile.fcmtoken = token??"";
    // userprofile.updateItem();
    //
    String uid = Provider.of<AuthBloc>(
                NavigationService.navigatorKey.currentContext!,
                listen: false)
            .uid ??
        '';
    Fcmtoken fcmtoken = Fcmtoken();
    //fcmtoken.setref('fcmtokens/$uid');
    int count = await fcmtoken.getItemsCountWhere('uid', uid);

    if (count < 1) {
      fcmtoken.token = token;
      fcmtoken.uid = uid;
      fcmtoken.addItem();
    } else {
      Fcmtoken item = Provider.of<FcmtokenContainer>(
              NavigationService.navigatorKey.currentContext!,
              listen: false)
          .content[0]['item'];
      item.token = token;
      item.updateItem();
    }
  }
}
