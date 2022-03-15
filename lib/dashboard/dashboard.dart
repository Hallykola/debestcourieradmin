import 'package:courieradmin/constants.dart';
import 'package:courieradmin/models/categoriescontainer.dart';
import 'package:courieradmin/signin/myauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';

import '../models/order.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool detailed = false;
  ScrollController controller = ScrollController();
  @override
  void initState() {
    super.initState();
    Order order = Order();
    order.getItems(context.read<DeliveriesContainer>()
        //Provider.of<DeliveriesContainer>(context, listen: false),
        );
  }

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    List<Map<String, dynamic>> order =
        context.watch<DeliveriesContainer>().content;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Row(
        children: [
          Expanded(
            child: Container(
              width: detailed
                  ? MediaQuery.of(context).size.width * 0.7
                  : MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(0.3),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //const Greeting(),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 30),
                      child: const Tabs(),
                    ),
                
                    Container(
                        // width: detailed
                        //     ? MediaQuery.of(context).size.width * 0.6
                        //     : screensize.width ,
                        height: screensize.height * 0.28,
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.green,
                          // image: DecorationImage(image: AssetImage('assets/images/banner.png'))
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                    height: screensize.height * 0.28,
                                    child:
                                        Image.asset('assets/images/banner.png'))),
                            Positioned(
                                top: 40,
                                left: 20,
                                child: Text('DBest Courier',
                                    style: h1LightStyle.copyWith(
                                        color: Colors.white))),
                            Positioned(
                              top: 80,
                              left: 20,
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: 'The Best Way to Send Packages\n',
                                    style: h2Style.copyWith(color: Colors.white)),
                                TextSpan(
                                    text: 'Anytime, anywhere',
                                    style: h2Style.copyWith(color: Colors.white)),
                              ])),
                            )
                          ],
                        )),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                decoration: boxDecowhite,
                                child: Text('23-4-22 - 23-5-22'),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SvgPicture.asset('assets/icons/globe.svg')
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                                controller: controller,
                                itemBuilder: (BuildContext context, int index) {
                                  return TableRow(
                                    press: () {
                                      setState(() {
                                        detailed = !detailed;
                                      });
                                    },
                                    origin: order[index]['item'].pickupaddress,
                                    destination:
                                        order[index]['item'].dropoffaddress,
                                    date: order[index]['item'].ordertime,
                                    status: order[index]['item'].deliverystatus,
                                    cost: double.parse((order[index]['item']
                                                    .costofdelivery ==
                                                "")
                                            ? '0'
                                            : order[index]['item']
                                                .costofdelivery)
                                        .toStringAsFixed(2),
                                  );
                                }),
                          ),
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
                    ),
                  ],
                ),
              ),
            ),
          ),
          detailed
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.shade200,
                  ),
                  child: SingleChildScrollView(
                    child: Expanded(
                      child: Column(
                        children:  [
                          SizedBox(
                            height: 30,
                          ), 
                          ...List.generate(
                              order.length,
                              (index) => TableRow(
                                press: () {
                                  setState(() {
                                    detailed = !detailed;
                                  });
                                },
                                origin: order[index]['item'].pickupaddress,
                                destination: order[index]['item'].dropoffaddress,
                                date: order[index]['item'].ordertime,
                                status: order[index]['item'].deliverystatus,
                                cost: double.parse((order[index]['item'].costofdelivery=="")?'0':order[index]['item'].costofdelivery).toStringAsFixed(2),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
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
            "Expand",
            style: bodyLightStyle,
          ),
        )),
      ]),
    );
  }
}

class Counter extends StatelessWidget {
  const Counter({
    Key? key,
    required this.number,
    required this.item,
  }) : super(key: key);
  final String number;
  final String item;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(40),
        margin: const EdgeInsets.all(40),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  offset: Offset(2, 4),
                  color: Colors.amberAccent,
                  blurRadius: 2)
            ]),
        child: Text.rich(TextSpan(children: [
          TextSpan(text: '$number\n', style: TextStyle(fontSize: 35)),
          TextSpan(text: '$item')
        ])));
  }
}

class Tabs extends StatelessWidget {
  const Tabs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            LinkTab(
                press: () {},
                title: 'List of Riders',
                icon: 'assets/icons/delivery-bike.svg'),
            LinkTab(
                press: () {},
                title: 'List of Users',
                icon: 'assets/icons/delivery-bike.svg'),
            LinkTab(
                press: () {},
                title: 'List of Orders',
                icon: 'assets/icons/delivery-bike.svg'),
            LinkTab(
                press: () {},
                title: 'Payments',
                icon: 'assets/icons/delivery-bike.svg'),
          ],
        ));
  }
}

class LinkTab extends StatelessWidget {
  const LinkTab({
    Key? key,
    required this.title,
    required this.icon,
    required this.press,
  }) : super(key: key);
  final String title;
  final String icon;
  final Function() press;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  offset: Offset(2, 4),
                  color: Colors.amberAccent,
                  blurRadius: 2)
            ]),
        child: Row(
          children: [
            // SvgPicture.asset(
            //   icon,
            //   height: 40,
            // ),
            //Icon(icon),
            // SizedBox(
            //   width: 10,
            // ),
            Text(title)
          ],
        ),
      ),
    );
  }
}

class Greeting extends StatelessWidget {
  const Greeting({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Dashboard',
            style: TextStyle(color: Colors.blueAccent),
          ),
          Text(
            'Howdy, ${context.watch<AuthBloc>().email}',
            style: TextStyle(color: Colors.blueAccent, fontSize: 30),
          ),
        ],
      ),
    );
  }
}

class SideBar extends StatelessWidget {
  const SideBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: [
        Spacer(flex: 3),
        IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
        Spacer(flex: 1),
        IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
        Spacer(flex: 1),
        IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
        Spacer(flex: 3),
        IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
        Spacer(flex: 2),
      ]),
    );
  }
}
