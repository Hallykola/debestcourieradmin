import 'package:courieradmin/constants.dart';
import 'package:courieradmin/signin/myauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Row(
          children: [
            SideBar(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Greeting(),
                    Wrap(children: const [
                      Counter(number: '45', item: 'Users'),
                      Counter(number: '450', item: 'Orders'),
                      Counter(number: '10', item: 'Riders')
                    ]),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // image: DecorationImage(image: AssetImage('assets/images/banner.png'))
                        ),
                        child: Image.asset('assets/images/banner.png')),
                  ],
                ),
                Column(
                  children: const [
                    SizedBox(
                      height: 30,
                    ),
                    Tabs(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
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
            SvgPicture.asset(
              icon,
              height: 40,
            ),
            //Icon(icon),
            SizedBox(
              width: 10,
            ),
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
            'Home',
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
