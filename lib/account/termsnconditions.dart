import 'dart:ui';

import 'package:courieradmin/Widgets/headerwithback.dart';
import 'package:courieradmin/Widgets/pagedesign.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';
import 'account.dart';

class TermsnConditions extends StatefulWidget {
  TermsnConditions({Key? key}) : super(key: key);

  @override
  State<TermsnConditions> createState() => _TermsnConditionsState();
}

class _TermsnConditionsState extends State<TermsnConditions> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double headerHeight = size.height * 0.23;
    return Scaffold(
        bottomNavigationBar: const BottomNav(
          activeTab: 2,
        ),
        backgroundColor: kPrimaryColor,
        body: PageDesign(
          sideChild: Container(),
          headerHeight: headerHeight,
          header: SizedBox(height: headerHeight, child: HeaderwithBack(title: 'Terms and Conditions',)),
          content: Container(
            padding: const EdgeInsets.all(15),
            child: const Text.rich(TextSpan(children: [
              TextSpan(
                  text: "Company Privacy Policy\n\n",
                  style: TextStyle(fontSize: 24, color: Colors.black)),
              TextSpan(
                  text: termsnconditions,
                  style: TextStyle(fontSize: 16, color: Colors.black)),
            ])),
          ),
          lastChild: Container(),
          fixedLastChild: Container(),
        ));
  }
}

