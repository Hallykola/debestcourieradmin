
import 'package:courieradmin/Widgets/mybutton.dart';
import 'package:courieradmin/Widgets/myform.dart';
import 'package:courieradmin/Widgets/myusualbutton.dart';
import 'package:courieradmin/Widgets/sigininoption.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Map<String, dynamic>> details;
    details = [
      {
        "title": "Email Address",
        "hintText": "Enter your Email Address",
        "press": (text) {},
        "controller": emailcontroller,
        "type": TextInputType.emailAddress,
      },
      {
        "title": "Password",
        "hintText": "Enter your Password",
        "press": (text) {},
        "controller": passwordcontroller,
        "type": TextInputType.visiblePassword,
        "hide": true,
      },
    ];
    return 
         Column(
          children: [
            MyForm(
              title: 'Login',
              details: details,
            ),
            MyButton(text: 'Continue', press: () {}),
            Text('or'),
            SizedBox(height:40),
            MyUsualButton(press:()=>Navigator.pushNamed(context, '/register'), text:  'REGISTER'),
         SizedBox(height:40),
         Container(
           width: 600,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SigninOptions(color: Colors.blue, text: "Facebook", press: () {}),
              SigninOptions(color: Colors.green, text: "Google", press: () {}),
              SigninOptions(color: Colors.red, text: "Twitter", press: () {}),
            ],
          ),
        ),
         ],
        );
     
    
  }
}
