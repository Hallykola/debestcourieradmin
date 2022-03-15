import 'package:courieradmin/Widgets/apptitle.dart';
import 'package:courieradmin/Widgets/pagedesign.dart';
import 'package:courieradmin/constants.dart';
import 'package:courieradmin/request/mapwidget.dart';
import 'package:courieradmin/request/pickup.dart';
import 'package:flutter/material.dart';

class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  TextEditingController origincontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double headerHeight = size.height * 0.2;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: PageDesign(
        sideChild: Column(
          children: [
            Container(
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.all(8),
                child: Icon(Icons.ac_unit)),
            Icon(Icons.ac_unit),
          ],
        ),
        shift: true,
        headerHeight: headerHeight,
        header: SizedBox(height: headerHeight, child: const AppTitle()),
        content: 
            Container(
              height: MediaQuery.of(context).size.height-headerHeight,
              // child: Pickup(
              //   searchcontroller:origincontroller ,press: (){},)
               ),
         
        lastChild: Container(),
        fixedLastChild: Container(),
      ),
    );
  }
}
