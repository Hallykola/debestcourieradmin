import 'package:courieradmin/register/register.dart';
import 'package:courieradmin/signin/signin.dart';
import 'package:courieradmin/widgets/apptitle.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Center(child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppTitle(),
          Container(
            //height:300,
            margin: const EdgeInsets.all(12),
            width: 600,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: const Register(),
          ),
        ],
      )),
    );
  }
}