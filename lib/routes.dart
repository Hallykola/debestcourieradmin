

import 'package:courieradmin/loginpage.dart';
import 'package:courieradmin/registerpage.dart';
import 'package:flutter/material.dart';

import 'dashboard/dashboard.dart';
import 'home/home.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/home': (context) => const Home(),
  '/register': (context) =>  RegisterPage(),
  '/': (context) =>  LoginPage(),
  '/dashboard': (context) => const Dashboard(),
  //   '/account': (context) => const Account(),

};
