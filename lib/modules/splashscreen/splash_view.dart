// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signboard/Core/Constant/value_constants.dart';
import 'package:signboard/modules/homescreen/home_view.dart';
import 'package:signboard/modules/loginscreen/login_view.dart';
import 'package:signboard/utils/image_path_constants.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  bool? isLogin;

  checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isLogin = pref.getBool(SHOWLOGIN);
    log(isLogin.toString());

    if (isLogin == true) {
      Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(
            builder: (context) => const HomeScreenView(),
          ),
          (route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(
            builder: (context) => const LoginScreenView(),
          ),
          (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      checkLogin();
      log("3 Sec...");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ImagePath.splashLogo,
              height: 243,
            ),
          ],
        ),
      ),
    );
  }
}
