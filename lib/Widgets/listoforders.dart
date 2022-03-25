import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';
import '../dashboard/dashBloc.dart';
import 'package:provider/provider.dart';

import '../models/categoriescontainer.dart';
import '../models/order.dart';

class ListOfOrders extends StatefulWidget {
  ListOfOrders({Key? key}) : super(key: key);

  @override
  State<ListOfOrders> createState() => _ListOfOrdersState();
}

class _ListOfOrdersState extends State<ListOfOrders> {
  String prevCursor = "";
  @override
  void initState() {
    super.initState();
    Order order = Order();
    // order.getItems(context.read<DeliveriesContainer>()
    //     //Provider.of<DeliveriesContainer>(context, listen: false),
    //     );
    order.getXItems(context.read<DeliveriesContainer>(), 10, "ordertimeepoch");
  }

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    bool detailed = context.watch<DashBloc>().detailed;
    List<Map<String, dynamic>> order =
        context.watch<DeliveriesContainer>().content;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: screensize.height * 0.5,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'All orders',
                style: h2Style,
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: boxDecowhite,
                child: Text('23-4-22 - 23-5-22'),
              ),
              const SizedBox(
                width: 10,
              ),
              SvgPicture.asset('assets/icons/globe.svg')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: 1, child: Text('')),
              Expanded(flex: 2, child: Text('Pickup Address')),
              Expanded(flex: 2, child: Text('Drop off Address')),
              Expanded(flex: 2, child: Text('Delivery Request Date')),
              Expanded(flex: 1, child: Text('Delivery Status')),
              Expanded(flex: 1, child: Text('Delivery Cost')),
              Expanded(flex: 1, child: Text('')),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: order.length,
                itemBuilder: (BuildContext context, int index) {
                  return TableRow(
                    press: () async {
                      setState(() {
                        // detailed = detailed;
                      });
                      Provider.of<DashBloc>(context, listen: false)
                          .setDetailed(false);
                      await Future.delayed(
                          const Duration(milliseconds: 20), () {});

                      Provider.of<DashBloc>(context, listen: false)
                          .setFocusedOrder(order[index]['item']);
                      Provider.of<DashBloc>(context, listen: false)
                          .setDetailed(true);
                    },
                    origin: order[index]['item'].pickupaddress,
                    destination: order[index]['item'].dropoffaddress,
                    date: order[index]['item'].ordertime,
                    status: order[index]['item'].deliverystatus,
                    cost: double.parse(
                            (order[index]['item'].costofdelivery == "")
                                ? '0'
                                : order[index]['item'].costofdelivery)
                        .toStringAsFixed(2),
                  );
                }),
          ),
          if (prevCursor != "")
            TextButton(
                onPressed: () {
                  print('here e dey o! ${order.length}');
                  setState(() {
                    prevCursor = order[9]['item'].ordertime;
                  });
                  Order neworder = Order();
                  neworder.getPrevXItems(context.read<DeliveriesContainer>(),
                      10, [prevCursor], "ordertimeepoch");
                },
                child: Text('Prev 10')),
          TextButton(
              onPressed: () {
                print('item length is ${order.length - 1}');
                setState(() {
                  prevCursor = order[9]['item'].ordertime;
                });
                print(prevCursor);
                Order neworder = Order();
                neworder.getNextXItems(context.read<DeliveriesContainer>(), 10,
                    [order[9]['item'].ordertime], "ordertimeepoch");
              },
              child: Text('Next 10'))
          // ...List.generate(
          //   order.length,
          //   (index) => TableRow(
          //     press: () {
          //       setState(() {
          //         detailed = !detailed;
          //       });
          //     },
          //     origin: order[index]['item'].pickupaddress,
          //     destination: order[index]['item'].dropoffaddress,
          //     date: order[index]['item'].ordertime,
          //     status: order[index]['item'].deliverystatus,
          //     cost: double.parse((order[index]['item'].costofdelivery=="")?'0':order[index]['item'].costofdelivery).toStringAsFixed(2),
          //   ),
          // ),
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
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: boxDecowhite,
      child: Row(children: [
        Expanded(child: SvgPicture.asset('assets/icons/package.svg')),
        Expanded(
            flex: 2,
            child: Text(
              origin,
              style: bodyLightStyle,
            )),
        Expanded(
            flex: 2,
            child: Text(
              destination,
              style: bodyLightStyle,
            )),
        Expanded(
            flex: 2,
            child: Text(
              date,
              style: bodyLightStyle,
            )),
        Expanded(
            child: Text(
          status,
          style: bodyLightStyle,
        )),
        Expanded(
            child: Text(
          cost,
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
