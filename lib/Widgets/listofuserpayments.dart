import 'package:courieradmin/models/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';
import '../dashboard/dashBloc.dart';
import 'package:provider/provider.dart';

import '../models/categoriescontainer.dart';
import '../models/payment.dart';

class ListOfUserPayments extends StatefulWidget {
  ListOfUserPayments({Key? key}) : super(key: key);

  @override
  State<ListOfUserPayments> createState() => _ListOfUserPaymentsState();
}

class _ListOfUserPaymentsState extends State<ListOfUserPayments> {
  String prevCursor = "";
  @override
  void initState() {
    super.initState();
    Payment payment = Payment();
    // payment.getItems(context.read<PaymentsContainer>()
    //     //Provider.of<PaymentsContainer>(context, listen: false),
    //     );
    payment.getXItems(context.read<PaymentsContainer>(), 10, "reference");
  }

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    bool detailed = context.watch<DashBloc>().detailed;
    List<Map<String, dynamic>> payment =
        context.watch<PaymentsContainer>().content;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'All user payments',
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
                itemCount: payment.length,
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
                            .setFocusedPayment(payment[index]['item']);
                        Provider.of<DashBloc>(context, listen: false)
                            .setDetailed(true);
                      },
                      amount: payment[index]['item'].amount,
                      paymenttime: payment[index]['item'].paymenttime,
                      details: payment[index]['item'].details,
                      distance: payment[index]['item'].distance,
                      paymentstatus: payment[index]['item'].paymentstatus,
                      paymentmode: payment[index]['item'].paymentmode);
                }),
          ),
          if (prevCursor != "")
            TextButton(
                onPressed: () {
                  print('here e dey o! ${payment.length}');
                  setState(() {
                    prevCursor = payment[9]['item'].paymenttime;
                  });
                  Payment neworder = Payment();
                  neworder.getPrevXItems(context.read<PaymentsContainer>(), 10,
                      [prevCursor], "reference");
                },
                child: Text('Prev 10')),
          TextButton(
              onPressed: () {
                print('item length is ${payment.length - 1}');
                setState(() {
                  prevCursor = payment[9]['item'].paymenttime;
                });
                print(prevCursor);
                Payment neworder = Payment();
                neworder.getNextXItems(context.read<PaymentsContainer>(), 10,
                    [payment[9]['item'].paymenttime], "reference");
              },
              child: Text('Next 10'))
        ],
      ),
    );
  }
}

class TableRow extends StatelessWidget {
  const TableRow({
    Key? key,
    required this.amount,
    required this.paymenttime,
    required this.details,
    required this.distance,
    required this.paymentmode,
    required this.paymentstatus,
    required this.press,
  }) : super(key: key);
  final double amount;
  final String paymenttime;
  final String details;
  final String distance;
  final String paymentmode;
  final String paymentstatus;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
      decoration: boxDecowhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
        Expanded(child: SvgPicture.asset('assets/icons/package.svg')),
        Expanded(
            flex: 2,
            child: Text(
              '$amount',
              style: bodyLightStyle,
            )),
        Expanded(
            flex: 2,
            child: Text(
              paymenttime,
              style: bodyLightStyle,
            )),
        Expanded(
            flex: 2,
            child: Text(
              details,
              style: bodyLightStyle,
            )),
        Expanded(
            child: Text(
          distance,
          style: bodyLightStyle,
        )),
        Expanded(
            child: Text(
          paymentmode,
          style: bodyLightStyle,
        )),
        Expanded(
            child: Text(
          paymentstatus,
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
