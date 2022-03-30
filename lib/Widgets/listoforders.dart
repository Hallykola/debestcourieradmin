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
  DateTime searchinit = DateTime(2021);
  DateTime searchfinal = DateTime(2021);
  int times = 10;
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
              Text(' (${context.watch<DeliveriesContainer>().container.length} entries)',style: h2Style,),
              const Spacer(),
              // Text(
              //     '${searchinit.microsecondsSinceEpoch} to ${searchfinal.millisecondsSinceEpoch}'),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                decoration: boxDecowhite,
                child: GestureDetector(
                    onTap: () async {
                      DateTime? initDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.parse("2021-01-01"),
                          helpText: 'Select initial date',
                          lastDate: DateTime.now());
                      DateTime? finalDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.parse("2021-01-01"),
                          helpText: 'Select final date',
                          lastDate: DateTime.now());
                      setState(() {
                        searchfinal = finalDate!;
                        searchinit = initDate!;
                      });
                      Order quickorder = Order();
                      quickorder.getItemsDateRange(
                          Provider.of<DeliveriesContainer>(context,
                              listen: false),
                          "ordertimeepoch",
                          initDate!.millisecondsSinceEpoch,
                          finalDate!.millisecondsSinceEpoch);
                    },
                    child: Icon(Icons.calendar_month)),
              ),
              const SizedBox(
                width: 10,
              ),
              // SvgPicture.asset('assets/icons/globe.svg')
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
          // if (prevCursor != "")
          //   TextButton(
          //       onPressed: () {
          //         print('here e dey o! ${order.length}');
          //         setState(() {
          //           prevCursor = order[9]['item'].ordertime;
          //         });
          //         Order neworder = Order();
          //         neworder.getPrevXItems(context.read<DeliveriesContainer>(),
          //             10, [prevCursor], "ordertimeepoch");
          //       },
          //       child: Text('Prev 10')),
          if (order.length % 10 == 0)
            TextButton(
                onPressed: () {
                  Order neworder = Order();
                  setState(() {
                    times += 10;
                  });
                  neworder.getXItems(context.read<DeliveriesContainer>(), times,
                      "ordertimeepoch");

                  // neworder.getNextXItems(context.read<DeliveriesContainer>(),
                  //     10, [context.read<DeliveriesContainer>().content[times-11]['item'].ordertimeepoch], "ordertimeepoch");
                },
                child: Text(
                    'Show 10 More')),
              
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
