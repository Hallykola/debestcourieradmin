import 'package:courieradmin/Widgets/apptitle.dart';
import 'package:courieradmin/Widgets/mybutton.dart';
import 'package:courieradmin/Widgets/myform.dart';
import 'package:courieradmin/Widgets/myforminput.dart';
import 'package:courieradmin/Widgets/pagedesign.dart';
import 'package:courieradmin/signin/myauth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../helpers.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController fullnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController controller = TextEditingController();
  TextEditingController phonenumbercontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController passwordagaincontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double headerHeight = size.height * 0.2;
    List<Map<String, dynamic>> details;
    details = [
      {
        "title": "Full Name",
        "hintText": "Enter your Full Name",
        "press": (text) {},
        "controller": fullnamecontroller
      },
      {
        "title": "Email Address",
        "hintText": "Enter your Email Address",
        "press": (text) {},
        "controller": emailcontroller,
        "type": TextInputType.emailAddress,
      },
      {
        "title": "Phone Number",
        "hintText": "Enter your Phone Number",
        "press": (text) {},
        "controller": phonenumbercontroller
      },
      {
        "title": "Password",
        "hintText": "Enter your Password",
        "press": (text) {},
        "controller": passwordcontroller,
        "type": TextInputType.visiblePassword,
        "hide": true,
      },
      {
        "title": "Re-type Password",
        "hintText": "Enter your Password again",
        "press": (text) {},
        "controller": passwordagaincontroller,
        "type": TextInputType.visiblePassword,
        "hide": true,
      },
    ];

    if (context.watch<AuthBloc>().isSignedIn) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed("/home");
      });
    }
    return  Column(
      children: [
        MyForm(
                title: 'Register',
                details: details,
              ),
      MyButton(
              text: 'Continue',
              press: () async {
                var errors = validateRegisterFrom(
                    fullnamecontroller.text,
                    emailcontroller.text,
                    phonenumbercontroller.text,
                    passwordcontroller.text,
                    passwordagaincontroller.text);
                print(errors);
                if (errors == "") {
                  var result =
                      await Provider.of<AuthBloc>(context, listen: false)
                          .signUpwithEmailPassword(fullnamecontroller.text,
                              emailcontroller.text, passwordcontroller.text,context);
                  if (!result) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          Provider.of<AuthBloc>(context, listen: false)
                              .errorCode!),
                      duration: const Duration(seconds: 3),
                    ));
                  } else {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("/home");
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(errors),
                    duration: const Duration(seconds: 5),
                  ));
                }
              }),
              const SizedBox(height: 30,) ],
    );
    
  }

  validateRegisterFrom(
      name, emailaddress, phonenumber, password, passwordagain) {
    //name
    String errors = "";
    if (name.toString().isEmpty) {
      errors += "Name can not be empty \n";
    }
    if (!validateemail(emailaddress)) {
      errors += "Email is invalid \n";
    }
    if (phonenumber.toString().isEmpty) {
      errors += "Phone number can not be empty \n";
    }
    if (!(password == passwordagain)) {
      errors += "The passwords you entered do not match \n";
    }
    return errors;
  }
}