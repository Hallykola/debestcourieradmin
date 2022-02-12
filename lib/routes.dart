

import 'package:courieradmin/loginpage.dart';
import 'package:courieradmin/registerpage.dart';
import 'package:flutter/material.dart';

import 'home/home.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/home': (context) => const Home(),
  '/register': (context) =>  RegisterPage(),
  '/': (context) =>  LoginPage(),
  // '/pickup': (context) => const Request(),
  //   '/account': (context) => const Account(),

};
