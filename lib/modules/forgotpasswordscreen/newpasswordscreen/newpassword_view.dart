// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signboard/Core/Constant/CommonUtils.dart';
import 'package:signboard/Core/Constant/url_constant.dart';
import 'package:signboard/modules/loginscreen/login_view.dart';
import 'package:signboard/modules/registerscreen/register_view.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/utils/image_path_constants.dart';
import 'package:signboard/utils/text_styles.dart';
import 'package:signboard/widgets/submit_button.dart';

class NewPassWordScreenView extends StatefulWidget {
  String? emailText;
  String? otptext;
  NewPassWordScreenView({super.key, this.emailText, this.otptext});

  @override
  State<NewPassWordScreenView> createState() => _NewPassWordScreenViewState();
}

class _NewPassWordScreenViewState extends State<NewPassWordScreenView> {
  TextEditingController newPassWordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  bool isTapShow1 = false;
  bool isTapShow2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Image.asset(
                    ImagePath.loginLogo,
                    height: 45,
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(left: 0, right: 0),
                    child: Text(
                      AppConstants.newPasswordHeading,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff848CA1)),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                          color: const Color(0xff5C5C65).withOpacity(0.13),
                        ),
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 0.2,
                            blurRadius: 10,
                            offset: const Offset(4, 6),
                            color: const Color(0xff000000).withOpacity(.1),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        obscureText: isTapShow1 == true ? true : false,
                        controller: newPassWordController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                borderSide: BorderSide.none),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Image.asset(
                                ImagePath.passwordImage,
                                height: 22,
                                width: 22,
                              ),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isTapShow1 = !isTapShow1;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Image.asset(
                                  isTapShow1 == false
                                      ? ImagePath.hidePassword
                                      : ImagePath.showPassword,
                                  height: 22,
                                  width: 22,
                                ),
                              ),
                            ),
                            hintText: AppConstants.newPasswordHint,
                            hintStyle: hintFieldTextStyle),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.0,
                            color: const Color(0xff5C5C65).withOpacity(0.13)),
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 0.2,
                            blurRadius: 10,
                            offset: const Offset(4, 6),
                            color: const Color(0xff000000).withOpacity(.1),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        obscureText: isTapShow2 == true ? true : false,
                        controller: confirmpasswordController,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                                borderSide: BorderSide.none),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Image.asset(
                                ImagePath.passwordImage,
                                height: 22,
                                width: 22,
                              ),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isTapShow2 = !isTapShow2;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Image.asset(
                                  isTapShow2 == false
                                      ? ImagePath.hidePassword
                                      : ImagePath.showPassword,
                                  height: 22,
                                  width: 22,
                                ),
                              ),
                            ),
                            hintText: AppConstants.confirmPasswordHint,
                            hintStyle: hintFieldTextStyle),
                      ),
                    ),
                  ),
                  SizedBox(height: 90),
                  CommonButton(
                      btnName: AppConstants.submitText,
                      btnOnTap: () {
                        if (confirmpasswordController.text ==
                            newPassWordController.text) {
                          resetPasswordAPI();
                        } else if (confirmpasswordController.text !=
                            newPassWordController.text) {
                          Fluttertoast.showToast(
                              msg: "Please Enter Correct Password");
                        } else {}
                      }),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          CupertinoPageRoute(
                            builder: (context) => RegisterScreenView(),
                          ),
                          (route) => false);
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: RichText(
                        textAlign: TextAlign.start,
                        maxLines: 3,
                        text: TextSpan(
                          text: AppConstants.dontHave,
                          style: regularRichStyle,
                          children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              RegisterScreenView(),
                                        ),
                                        (route) => false);
                                  },
                                text: AppConstants.signUp,
                                style: TextStyle(
                                    color: Color(0xffA13FF5),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  resetPasswordAPI() async {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    CommonUtils.showProgressLoading(context);
    try {
      var params = {
        "email": widget.emailText,
        "otp_code": widget.otptext,
        "new_password": newPassWordController.text
      };
      log("Reset Params ::::::$params");
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
        dioClient.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      };
      var response =
          await dio.post(RESET_PASSWORD_URl, data: jsonEncode(params));
      log("Reset Respnse::::::${response.data}");
      if (response.statusCode == 200) {
        CommonUtils.hideProgressLoading(context);
        Fluttertoast.showToast(msg: response.data["message"]);

        Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(
              builder: (context) => const LoginScreenView(),
            ),
            (route) => false);
      } else {
        CommonUtils.hideProgressLoading(context);
        Fluttertoast.showToast(msg: response.data["message"]);
      }
    } on DioError catch (e) {
      log("Login error $e");
    }
  }
}
