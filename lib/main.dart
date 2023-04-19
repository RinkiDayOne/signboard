// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signboard/demo.dart';
import 'package:signboard/dhamo.dart';
import 'package:signboard/modules/homescreen/drawerscreen/myadvertsscreen/myadvertsdemo.dart';
import 'package:signboard/modules/splashscreen/splash_view.dart';
import 'package:signboard/modules/uploadsignboardscreen/paymentscreen/payment_view.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  HttpClient httpClient = HttpClient();
  httpClient.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  runApp(MyApp());
  HttpOverrides.global = MyHttpOverrides();
}



class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.montserratTextTheme()),
      home:
      // MyStatefulWidget() 
      // MyHomePage(),
      SplashScreenView(),
      // DemoScreen()
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}


