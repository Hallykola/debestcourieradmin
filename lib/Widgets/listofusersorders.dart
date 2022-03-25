import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';
import '../dashboard/dashBloc.dart';
import 'package:provider/provider.dart';

import '../models/categoriescontainer.dart';
import '../models/order.dart';

class ListOfUserOrders extends StatefulWidget {
  ListOfUserOrders({Key? key, required this.uid, required this.usertype})
      : super(key: key);
  final String uid;
  final UserType usertype;

  @override
  State<ListOfUserOrders> createState() => _ListOfUserOrdersState();
}

class _ListOfUserOrdersState extends State<ListOfUserOrders> {
  List<Map<String, dynamic>>? order;
  @override
  void initState() {
    super.initState();
    Order anorder = Order();
    fectchOrders(anorder);
  }

  fectchOrders(Order order) async {
    switch (widget.usertype) {
      case UserType.RIDER:
        await order.getItemsWhereBy(context.read<UserDeliveriesContainer>(),
            'rideruid', widget.uid, "ordertimeepoch");
        break;
      case UserType.USER:
        await order.getItemsWhereBy(context.read<UserDeliveriesContainer>(),
            'senderuid', widget.uid, "ordertimeepoch");
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    bool detailed = context.watch<DashBloc>().detailed;
     order =
        context.watch<UserDeliveriesContainer>().content;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      //height: screensize.height * 0.5,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'All User\'s orders',
                style: h2Style,
              ),
              const Spacer(),
              TextButton(
                
                onPressed: () {
                Provider.of<DashBloc>(context, listen: false)
                            .setDetailed(false);
              }, child: Text('Close',style: TextStyle(color: Colors.white),)),
            ],
          ),
          Expanded(
            child: ListView.builder(
              controller: ScrollController(),
                itemCount: order!.length,
                itemBuilder: (BuildContext context, int index) {
                  return TableRow(
                    press: () async{
                      setState(() {
                        // detailed = detailed;
                        
                      });
                      Provider.of<DashBloc>(context, listen: false)
                            .setDetailed(false);
                      await Future.delayed(const Duration(seconds: 5), (){});
                      Provider.of<DashBloc>(context, listen: false)
                            .setDetailed(true);
                        Provider.of<DashBloc>(context, listen: false)
                            .setFocusedOrder(order![index]['item']);
                    },
                    origin: order![index]['item'].pickupaddress,
                    destination: order![index]['item'].dropoffaddress,
                    date: order![index]['item'].ordertime,
                    status: order![index]['item'].deliverystatus,
                    cost: double.parse(
                            (order![index]['item'].costofdelivery == "")
                                ? '0'
                                : order![index]['item'].costofdelivery)
                        .toStringAsFixed(2),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class TableRow extends StatelessWidget {
  const TableRow({
    Key? key,
    required this.origin,
    required this.destination,
    required this.date,
    required this.status,
    required this.cost,
    required this.press,
  }) : super(key: key);
  final String origin;
  final String destination;
  final String date;
  final String status;
  final String cost;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:200,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
      padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
      decoration: boxDecowhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
        Expanded(
            flex: 2,
            child: Text(
              'Pick up: $origin',
              style: bodyLightStyle,
            )),
        Expanded(
            flex: 2,
            child: Text(
              'Drop off: $destination',
              style: bodyLightStyle,
            )),
        Expanded(
            flex: 2,
            child: Text(
              'Date: $date',
              style: bodyLightStyle,
            )),
            
        Expanded(
            child: Text(
          'Status: $status',
          style: bodyLightStyle,
        )),
        Expanded(
            child: Text(
          'Cost: $cost',
          style: bodyLightStyle,
        )),
        Expanded(
            child: GestureDetector(
          onTap: press,
          child: const Text(
            "Show Details",
            style: bodyLightStyle,
          ),
        )),
      ]),
    );
  }
}

enum UserType { USER, RIDER }
