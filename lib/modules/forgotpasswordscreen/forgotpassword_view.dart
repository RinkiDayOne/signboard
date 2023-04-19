// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signboard/Core/Constant/CommonUtils.dart';
import 'package:signboard/Core/Constant/url_constant.dart';
import 'package:signboard/modules/forgotpasswordscreen/otpbottomsheet/otpbottomsheet_view.dart';
import 'package:signboard/modules/loginscreen/login_view.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/utils/image_path_constants.dart';
import 'package:signboard/utils/text_styles.dart';
import 'package:signboard/widgets/submit_button.dart';

class ForgotpasswordScreenView extends StatefulWidget {
  const ForgotpasswordScreenView({super.key});

  @override
  State<ForgotpasswordScreenView> createState() =>
      _ForgotpasswordScreenViewState();
}

class _ForgotpasswordScreenViewState extends State<ForgotpasswordScreenView> {
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F7FB),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Image.asset(
                    ImagePath.loginLogo,
                    height: 45,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    AppConstants.forgotHeadingText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff848CA1)),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.0,
                        color: const Color(0xff5C5C65).withOpacity(0.13),
                      ),
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
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
                      controller: emailController,
                      textInputAction: TextInputAction.done,
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
                              ImagePath.email,
                              height: 22,
                              width: 22,
                            ),
                          ),
                          hintText: AppConstants.forgotHint,
                          hintStyle: hintFieldTextStyle),
                    ),
                  ),
                  const SizedBox(height: 80),
                  CommonButton(
                    btnName: AppConstants.sendOtp,
                    btnOnTap: () {
                      if (formKey.currentState!.validate()) {
                        checkConnection();
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      text: TextSpan(
                        text: AppConstants.alreadyAccount,
                        style: regularRichStyle,
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            const LoginScreenView(),
                                      ),
                                      (route) => false);
                                },
                              text: AppConstants.signIn,
                              style: const TextStyle(
                                  color: Color(0xffA13FF5),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(
                          color: const Color(0xff5C5C65).withOpacity(.20),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Spacer(),
                          Image.asset(ImagePath.google, height: 22, width: 22),
                          const SizedBox(width: 10),
                          const Text(
                            AppConstants.google,
                            style: TextStyle(
                                color: Color(0xff646B7B),
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(
                          color: const Color(0xff5C5C65).withOpacity(.20),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Spacer(),
                          Image.asset(ImagePath.apple, height: 22, width: 22),
                          const SizedBox(width: 10),
                          const Text(
                            AppConstants.apple,
                            style: TextStyle(
                                color: Color(0xff646B7B),
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      forgotPasswordAPI();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      forgotPasswordAPI();
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Alert"),
              content: Text("Check Your Internet Connection"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok")),
              ],
            );
          });
    }
  }

  forgotPasswordAPI() async {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    CommonUtils.showProgressLoading(context);
    try {
      var params = {
        "email": emailController.text,
      };
      log("Forgot Params ::::::$params");
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
        dioClient.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      };
      var response =
          await dio.post(FORGOT_PASSWORD_URl, data: jsonEncode(params));
      log("Forgot Respnse::::::${response.data}");
      if (response.statusCode == 200) {
        CommonUtils.hideProgressLoading(context);
        Fluttertoast.showToast(msg: response.data["message"]);
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: false,
          // transitionAnimationController: controller,
          // isDismissible: true,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return Container(
              height: 380,
              color: Colors.white,
              child: OtpBottomSheetView(
                email: emailController.text.isNotEmpty
                    ? emailController.text
                    : "**@gmail.com",
              ),
            );
          },
        );
        /* Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(
                builder: (context) => const HomeScreenView(),
              ),
              (route) => false); */
      } else {
        CommonUtils.hideProgressLoading(context);
        Fluttertoast.showToast(msg: response.data["message"]);
      }
    } on DioError catch (e) {
      log("Login error $e");
    }
  }
}
