import 'package:courieradmin/Widgets/mybutton.dart';
import 'package:courieradmin/Widgets/myform.dart';
import 'package:courieradmin/Widgets/myusualbutton.dart';
import 'package:courieradmin/Widgets/sigininoption.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../helpers.dart';
import 'myauth.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();

  AuthBloc? authBloc;
  @override
  void initState() {
    super.initState();
    authBloc = Provider.of<AuthBloc>(context, listen: false);
  }

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
    if (context.watch<AuthBloc>().isSignedIn) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed("/dashboard");
      });
    }

    return Column(
      children: [
        MyForm(
          title: 'Login',
          details: details,
        ),
        MyButton(
            text: 'Continue',
            press: () async {
              if (validateemail(emailcontroller.text)) {
                var result = await authBloc!.signInwithEmailPassword(context,
                    emailcontroller.text, passwordcontroller.text);
                if (!result) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(Provider.of<AuthBloc>(context, listen: false)
                        .errorCode
                        .toString()),
                    duration: const Duration(seconds: 5),
                  ));
                } else {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed("/dashboard");
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Email is invalid"),
                  duration: Duration(seconds: 2),
                ));
              }
            }),
        Text('or'),
        SizedBox(height: 40),
        MyUsualButton(
            press: () => Navigator.pushNamed(context, '/register'),
            text: 'REGISTER'),
        SizedBox(height: 40),
        Container(
          width: 600,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SigninOptions(color: Colors.blue, text: "Facebook", press: () {}),
              SigninOptions(
                  color: Colors.green,
                  text: "Google",
                  press: () {
                    authBloc!.signInWithGoogle(context);
                  }),
              SigninOptions(color: Colors.red, text: "Twitter", press: () {}),
            ],
          ),
        ),
      ],
    );
  }
}
