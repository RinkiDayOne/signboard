// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signboard/Core/Constant/value_constants.dart';
import 'package:signboard/modules/homescreen/home_view.dart';
import 'package:signboard/modules/loginscreen/login_view.dart';
import 'package:signboard/modules/registerscreen/viewbybox/viewby_view.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/utils/image_path_constants.dart';
import 'package:signboard/utils/text_styles.dart';
import 'package:signboard/widgets/submit_button.dart';

class WarningView extends StatefulWidget {
  String? fromValue;
  WarningView({super.key, this.fromValue});

  @override
  State<WarningView> createState() => _WarningViewState();
}

class _WarningViewState extends State<WarningView> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.only(left: 0, right: 0),
      content: Container(
        height: 505,
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
              Image.asset(ImagePath.warningImage, height: 233),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Text(
                  AppConstants.warningForYou,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xffEA4335),
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Text('\u2022'),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          AppConstants.playSafe,
                          style: TextStyle(
                              color: Color(0xff46484F),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Text('\u2022'),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          AppConstants.jobsThorough,
                          style: TextStyle(
                              color: Color(0xff46484F),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Text('\u2022'),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          AppConstants.inspectProducts,
                          style: TextStyle(
                              color: Color(0xff46484F),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              /* const Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Text(
                  AppConstants.logoutApp,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff848CA1),
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
              ), */
              const SizedBox(height: 15),
              CommonButton(
                btnOnTap: () {
                  appLogin();
                },
                btnName: AppConstants.iUnderstoodText,
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  appLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(SHOWLOGIN, true);
    if (widget.fromValue == "Register") {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => StatefulBuilder(
                builder: (BuildContext context,
                    void Function(void Function()) setState) {
                  return ViewByScreen();
                },
              ));
    } else if (widget.fromValue == "Login") {}
    Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(
          builder: (context) => const HomeScreenView(),
        ),
        (route) => false);
  }
}
