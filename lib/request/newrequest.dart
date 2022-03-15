import 'package:courieradmin/Widgets/stepsbutton.dart';
import 'package:intl/intl.dart';
import 'package:courieradmin/constants.dart';
import 'package:courieradmin/models/order.dart';
import 'package:courieradmin/request/confirminfo.dart';
import 'package:courieradmin/request/courierinfo.dart';
import 'package:courieradmin/request/pickup.dart';
import 'package:courieradmin/request/requestorderbloc.dart';
import 'package:courieradmin/signin/myauth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class NewRequest extends StatefulWidget {
  const NewRequest({
    Key? key,
  }) : super(key: key);

  @override
  State<NewRequest> createState() => _NewRequestState();
}

class _NewRequestState extends State<NewRequest> {
  TextEditingController originnamecontroller = TextEditingController();
  TextEditingController destinationnamecontroller = TextEditingController();
  TextEditingController originphonecontroller = TextEditingController();
  TextEditingController destinationphonecontroller = TextEditingController();
  TextEditingController originaddresscontroller = TextEditingController();
  TextEditingController destinationaddresscontroller = TextEditingController();
  List<Map<String, dynamic>> icons = [
    {
      'title': 'Pick up Location',
      'icon': 'assets/icons/startup.svg',
      'press': () {}
    },
    {
      'title': 'Drop off Location',
      'icon': 'assets/icons/destination.svg',
      'press': () {}
    },
    {
      'title': 'Package Details',
      'icon': 'assets/icons/package-dolly.svg',
      'press': () {}
    },
    {
      'title': 'Confirm Info',
      'icon': 'assets/icons/product.svg',
      'press': () {}
    },
  ];
  int position = 0;
  PageController? pageController;
  MyCoord origin = MyCoord();
  MyCoord destination = MyCoord();

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    Order myorder = context.watch<RequestOrderBloc>().currentorder;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Text(icons[position]['title'],
                style: TextStyle(fontSize: 20, color: Colors.white)),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  onPageChanged: (page) {
                    setState(() {
                      position = page;
                    });
                  },
                  children: [
                    Pickup(
                      coordinate: origin,
                      namecontroller: originnamecontroller,
                      addresscontroller: originaddresscontroller,
                      phonecontroller: originphonecontroller,
                      press: () {
                        myorder.sendername = originnamecontroller.text;
                        myorder.senderphone = originphonecontroller.text;
                        myorder.pickupaddress = originaddresscontroller.text;
                        myorder.senderuid =
                            Provider.of<AuthBloc>(context, listen: false).uid;
                        myorder.pickupaddresslat =
                            origin.position!.latitude.toString();
                        myorder.pickupaddresslng =
                            origin.position!.longitude.toString();
                        moveToPage(position + 1);
                      },
                    ),
                    Pickup(
                      coordinate: destination,
                      namecontroller: destinationnamecontroller,
                      addresscontroller: destinationaddresscontroller,
                      phonecontroller: destinationphonecontroller,
                      press: () {
                        myorder.receivername = destinationnamecontroller.text;
                        myorder.receiverphone = destinationphonecontroller.text;
                        myorder.dropoffaddress =
                            destinationaddresscontroller.text;
                        myorder.receiveruid =
                            "might not be a user of the system";
                        myorder.packagetype = "not set";
                        myorder.dropoffaddresslat =
                            destination.position!.latitude.toString();
                        myorder.dropoffaddresslng =
                            destination.position!.longitude.toString();
                        print(destination.position!.latitude.toString());
                        moveToPage(position + 1);
                      },
                    ),
                    CourierInfo(
                      order: myorder,
                    ),
                    ConfirmInfo(
                      order: myorder,
                      press: () async {
                        // print('hello');
                        DateTime now = DateTime.now();
                        String formattedDate =
                            DateFormat('kk:mm:ss \n EEE d MMM').format(now);
                        myorder.ordertime = formattedDate;
                        await myorder.addItem();
                        print(myorder.packagetype);
                        //myorder.updateItem();
                        print('hello again');
                      },
                    )
                  ],
                ),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    icons.length,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: StepButtons(
                              active: (index == position),
                              press: () {
                                setState(() {
                                  position = index;
                                  pageController!.animateToPage(index,
                                      duration: Duration(seconds: 1),
                                      curve: Curves.easeInOut);
                                });
                              }, //icons[index]['press'],
                              svgsrc: icons[index]['icon']),
                        ))),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  moveToPage(int index) {
    pageController!.animateToPage(index,
        duration: const Duration(seconds: 1), curve: Curves.easeInOut);
  }
}

class MyCoord {
  LatLng? position;
}
