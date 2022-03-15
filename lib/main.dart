import 'dart:ui';

import 'package:courieradmin/loginpage.dart';
import 'package:courieradmin/order/requestorderbloc.dart';
import 'package:courieradmin/profile/profileBloc.dart';
import 'package:courieradmin/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Widgets/utilbloc.dart';
import 'models/categoriescontainer.dart';
import 'savedaddress/savedaddressbloc.dart';
import 'signin/myauth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCMhpjJWoeMyriBG9ZgqpgsH4autxCZC9Y",
        authDomain: "debest-courier.firebaseapp.com",
        projectId: "debest-courier",
        storageBucket: "debest-courier.appspot.com",
        messagingSenderId: "76887572485",
        appId: "1:76887572485:web:0c5ec0917fb4156cd25c6c",
        measurementId: "G-9F6BFH8JB8"),
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthBloc()),
    ChangeNotifierProvider(create: (_) => ProfilesContainer()),
    ChangeNotifierProvider(create: (_) => OtherProfilesContainer()),
    ChangeNotifierProvider(create: (_) => RequestOrderBloc()),
    ChangeNotifierProvider(create: (_) => ProfileBloc()),
    ChangeNotifierProvider(create: (_) => SavedAddressContainer()),
    ChangeNotifierProvider(create: (_) => SavedAddressBloc()),
    ChangeNotifierProvider(create: (_) => DeliveriesContainer()),
    ChangeNotifierProvider(create: (_) => UtilBloc()),
    ChangeNotifierProvider(create: (_) => FcmtokenContainer()),
    ChangeNotifierProvider(create: (_) => PaymentsContainer()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: {PointerDeviceKind.mouse},),
       navigatorKey: NavigationService.navigatorKey,
      title: 'Courier Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      //home: LoginPage(), //const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class NavigationService { 
  static GlobalKey<NavigatorState> navigatorKey = 
  GlobalKey<NavigatorState>();
}