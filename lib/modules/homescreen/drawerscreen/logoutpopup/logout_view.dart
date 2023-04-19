// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signboard/Core/Constant/value_constants.dart';
import 'package:signboard/modules/loginscreen/login_view.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/utils/image_path_constants.dart';
import 'package:signboard/utils/text_styles.dart';
import 'package:signboard/widgets/submit_button.dart';

class LogoutView extends StatefulWidget {
  const LogoutView({super.key});

  @override
  State<LogoutView> createState() => _LogoutViewState();
}

class _LogoutViewState extends State<LogoutView> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.only(left: 0, right: 0),
      content: Container(
        height: 420,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 22,
                    width: 22,
                    color: Colors.transparent,
                  ),
                  const Spacer(),
                  const Text(
                    "",
                    style: TextStyle(
                        color: Color(0xff2C3E50),
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Image.asset(ImagePath.cancleImage,
                          height: 22, width: 22),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Image.asset(ImagePath.logOutImage, height: 176),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Text(
                  AppConstants.wantLogout,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff626E79),
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Text(
                  AppConstants.logoutApp,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff848CA1),
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 15),
              CommonButton(
                btnOnTap: () {
                  appLogout();
                },
                btnName: AppConstants.logOut,
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  appLogout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(SHOWLOGIN, false);
    Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(
          builder: (context) => const LoginScreenView(),
        ),
        (route) => false);
  }
}
