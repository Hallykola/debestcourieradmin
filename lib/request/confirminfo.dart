import 'dart:ui';

import 'package:courieradmin/Widgets/addresstile.dart';
import 'package:courieradmin/Widgets/icontextbutton.dart';
import 'package:courieradmin/Widgets/info.dart';
import 'package:courieradmin/Widgets/myusualbutton.dart';
import 'package:courieradmin/Widgets/tripoverviewmap.dart';
import 'package:courieradmin/constants.dart';
import 'package:courieradmin/models/order.dart';
import 'package:courieradmin/request/courierinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConfirmInfo extends StatefulWidget {
  final Function()? press;
  final Order order;
  ConfirmInfo({Key? key, this.press, required this.order}) : super(key: key) {
    // press = press;
  }

  @override
  _ConfirmInfoState createState() => _ConfirmInfoState();
}

class _ConfirmInfoState extends State<ConfirmInfo> {
  late Function() press;
  int deliverymodeindex = 0;

  @override
  void initState() {
    super.initState();
    press = widget.press ??
        () {
          print('wesere');
        };
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          MyContainer(
              child: Column(
            children: [
              AddressTile(
                  Svgsrc: 'assets/icons/location-pin.svg',
                  name: '${widget.order.sendername ?? "No name yet"}',
                  address: "${widget.order.pickupaddress ?? "No address yet"}",
                  phone: '${widget.order.senderphone ?? "No phone number"}'),
              const SizedBox(
                height: 10,
              ),
              AddressTile(
                  Svgsrc: 'assets/icons/destination.svg',
                  name: '${widget.order.receivername ?? "No name yet"}',
                  address: "${widget.order.dropoffaddress ?? "No address yet"}",
                  phone: '${widget.order.receiverphone ?? "No phone number"}')
            ],
          )),
          const SizedBox(
            height: 10,
          ),
          MyContainer(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Info(title: 'Distance', value: 'Check on map'),
                  IconTextButton(
                    text: 'View in Map',
                    press: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TripOverviewMap(order: widget.order)));
                    },
                    Svgsrc: 'assets/icons/location-pin.svg',
                  )
                ]),
          ),
          const SizedBox(
            height: 10,
          ),
          MyContainer(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Info(
                  title: 'Courier Type',
                  value: '${widget.order.packagetype ?? "Not chosen"}'),
              Info(
                  title: 'Frangible',
                  value: '${widget.order.packagefrangible ?? "Not stated"}'),
            ],
          )),
          const SizedBox(
            height: 10,
          ),
          MyContainer(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Info(
                  title: 'Height Width Length',
                  value:
                      '${widget.order.packageheight ?? "0"} X ${widget.order.packagewidth ?? "0"} X ${widget.order.packagelength ?? "0"} (cm)'),
              Info(
                  title: 'Weight',
                  value: '${widget.order.packageweight ?? "0"}'),
            ],
          )),
          const SizedBox(
            height: 10,
          ),
          MyContainer(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Info(
                    title: 'Courier info',
                    value: '${widget.order.packagedetail ?? ""}'),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              showModal(context);
            },
            child: MyContainer(
                child: Row(
              children: [
                Info(
                  title: 'Delivery Mode',
                  value: 'Economy Delivery',
                ),
                Spacer(),
                Text('\$8.60'),
                Icon(Icons.arrow_downward),
              ],
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: MyUsualButton(press: press, text: 'Proceed to Payment'),
          ),
        ],
      ),
    ));
  }

  showModal(context) {
    List<Map<String, dynamic>> options = [
      {
        "title": "Economy Delivery",
        "info": "Usually takes 2-3 days to deliver.",
        "charge": "\$8.60"
      },
      {
        "title": "Delux Delivery",
        "info": "Assured 6 hour delivery.",
        "charge": "\$12.00"
      },
      {
        "title": "Premium Delivery",
        "info": "Dedicated delivery boy deliver in 2-3 hours.",
        "charge": "\$20.00"
      },
    ];
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Select Delivery Mode'),
                const SizedBox(height: 8),
                ...List.generate(
                    options.length,
                    (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              deliverymodeindex = index;
                              widget.order.deliverymode =
                                  options[index]['title'];
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(8),
                                  height: 16,
                                  width: 16,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: (widget.order.deliverymode ==
                                                options[index]['title'])
                                            ? kPrimaryColor
                                            : Colors.black,
                                        width: 2),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(options[index]['title'],
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            fontSize: 24)),
                                    Text(options[index]['info'],
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6))),
                                  ],
                                ),
                                Spacer(),
                                Text(options[index]['charge'],
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.6))),
                              ],
                            ),
                          ),
                        ))
              ],
            ),
          );
        });
  }
}
