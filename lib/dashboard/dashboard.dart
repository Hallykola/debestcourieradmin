import 'package:courieradmin/Widgets/listofpayments.dart';
import 'package:courieradmin/Widgets/listofriders.dart';
import 'package:courieradmin/Widgets/listofusers.dart';
import 'package:courieradmin/Widgets/tripoverviewmap.dart';
import 'package:courieradmin/constants.dart';
import 'package:courieradmin/dashboard/dashBloc.dart';
import 'package:courieradmin/models/categoriescontainer.dart';
import 'package:courieradmin/signin/myauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';

import '../Widgets/listoforders.dart';
import '../Widgets/listofuserpayments.dart';
import '../Widgets/listofusersorders.dart';

import '../models/order.dart';
import '../models/payment.dart';
import '../models/profile.dart';
import '../profile/profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // bool detailed = false;
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    // Order order = Order();
    // order.getItems(context.read<DeliveriesContainer>()
    //     //Provider.of<DeliveriesContainer>(context, listen: false),
    //     );
    context.read<DashBloc>().setDetailed(false);
  }

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    // List<Map<String, dynamic>> order =
    //     context.watch<DeliveriesContainer>().content;
    ListType listtodisplay = context.watch<DashBloc>().displayOnDash;
    bool detailed = context.watch<DashBloc>().detailed;
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //const Greeting(),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: const Tabs(),
                  ),

                  Banner(screensize: screensize),
                  showlist(listtodisplay),
                ],
              ),
            ),
          ),
          detailed
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.shade200,
                  ),
                  child: showDetail( context.watch<DashBloc>(),listtodisplay),)
              //     (context.watch<DashBloc>().focusedOrder != null)
              //         ? TripOverviewMap(
              //             order: context.watch<DashBloc>().focusedOrder!)
              //         : Container(),
              //   )
               : Container(),
        ],
      ),
    );
  }

  showDetail(bloc,ListType listtodisplay ){
  Order? focusedOrder =  bloc.focusedOrder;
  Profile? focusedUserProfile = bloc.focusedUserProfile;
  Profile? focusedRiderProfile = bloc.focusedRiderProfile;
  Payment? focusedPayment = bloc.focusedPayment;
   switch (listtodisplay) {
  
     case ListType.ORDERS:
        if(focusedOrder==null){
          return Container();
        }
        return TripOverviewMap(
                          order: context.watch<DashBloc>().focusedOrder!);
      case ListType.USERS:
       if(focusedUserProfile==null){
          return Container();
        }
        return  ListOfUserOrders(uid: focusedUserProfile.uid,usertype: UserType.USER);
      case ListType.RIDERS:
      if(focusedRiderProfile==null){
          return Container;
        }
        return  ListOfUserOrders(uid: focusedRiderProfile.uid,usertype: UserType.RIDER,);
      case ListType.PAYMENTS:
      if(focusedPayment==null){
          return Container();
        }
        return ListOfUserPayments();
     default:
      return Container();
   }
    
  }
  showlist(ListType lists) {
    switch (lists) {
      case ListType.ORDERS:
        return ListOfOrders();
      case ListType.USERS:
        return ListOfUsers();
      case ListType.RIDERS:
        return ListOfRiders();
      case ListType.PAYMENTS:
        return ListOfPayments();
      default:
    }
  }
}

enum ListType { RIDERS, USERS, PAYMENTS, ORDERS }

class Banner extends StatelessWidget {
  const Banner({
    Key? key,
    required this.screensize,
  }) : super(key: key);

  final Size screensize;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    child: Image.asset('assets/images/banner.png'))),
            Positioned(
                top: 40,
                left: 20,
                child: Text('DBest Courier',
                    style: h1LightStyle.copyWith(color: Colors.white))),
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
        ));
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
    DashBloc dashbloc = context.read<DashBloc>();
    return SingleChildScrollView(
      controller: ScrollController(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            LinkTab(
                press: () {
                  Provider.of<DashBloc>(context, listen: false)
                            .setDetailed(false);
                  dashbloc.setDisplayOnDash(ListType.ORDERS);
                },
                title: 'List of Orders',
                icon: 'assets/icons/delivery-bike.svg'),
            LinkTab(
                press: () {
                  Provider.of<DashBloc>(context, listen: false)
                            .setDetailed(false);
                  dashbloc.setDisplayOnDash(ListType.RIDERS);
                },
                title: 'List of Riders',
                icon: 'assets/icons/delivery-bike.svg'),
            LinkTab(
                press: () {
                  Provider.of<DashBloc>(context, listen: false)
                            .setDetailed(false);
                  dashbloc.setDisplayOnDash(ListType.USERS);
                },
                title: 'List of Users',
                icon: 'assets/icons/delivery-bike.svg'),
            LinkTab(
                press: () {
                  Provider.of<DashBloc>(context, listen: false)
                            .setDetailed(false);
                  dashbloc.setDisplayOnDash(ListType.PAYMENTS);
                },
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
