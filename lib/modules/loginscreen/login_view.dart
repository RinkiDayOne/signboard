// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, use_build_context_synchronously, deprecated_member_use

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
import 'package:signboard/Core/Constant/value_constants.dart';
import 'package:signboard/models/login_model.dart';
import 'package:signboard/modules/forgotpasswordscreen/forgotpassword_view.dart';
import 'package:signboard/modules/homescreen/drawerscreen/privacypolicyscreen/privacy_view.dart';
import 'package:signboard/modules/homescreen/drawerscreen/termsscreen/terms_view.dart';
import 'package:signboard/modules/homescreen/home_view.dart';
import 'package:signboard/modules/loginscreen/warningscreen/warning_view.dart';
import 'package:signboard/modules/registerscreen/register_view.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/utils/image_path_constants.dart';
import 'package:signboard/utils/text_styles.dart';
import 'package:signboard/widgets/submit_button.dart';

class LoginScreenView extends StatefulWidget {
  const LoginScreenView({super.key});

  @override
  State<LoginScreenView> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreenView> {
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isTapShow = false;
  bool check1 = false;
  bool check2 = false;
  bool dontcheck = false;
  LoginModel? loginModel;
  final formKey = GlobalKey<FormState>();
  bool isShowForgot = false;

  @override
  void initState() {
    super.initState();
    mailController.text = "dhruvvv@gmail.com";
    passwordController.text = "111111111";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F7FB),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 10),
                      Image.asset(
                        ImagePath.loginLogo,
                        height: 45,
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Text(
                          AppConstants.loginHeading,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff848CA1)),
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.0,
                              color: Color(0xff5C5C65).withOpacity(0.13),
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 0.2,
                                blurRadius: 10,
                                offset: Offset(4, 6),
                                color: Color(0xff000000).withOpacity(.1),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: mailController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
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
                                hintText: "Enter Your Email",
                                hintStyle: hintFieldTextStyle),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.0,
                                color: Color(0xff5C5C65).withOpacity(0.13)),
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 0.2,
                                blurRadius: 10,
                                offset: Offset(4, 6),
                                color: Color(0xff000000).withOpacity(.1),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            obscureText: isTapShow == true ? true : false,
                            controller: passwordController,
                            textInputAction: TextInputAction.done,
                            onChanged: (value) {
                              if (passwordController.text.isEmpty) {
                                setState(() {
                                  isShowForgot = true;
                                });
                              } else {
                                setState(() {
                                  isShowForgot = false;
                                });
                              }
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
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
                                suffixIcon: isShowForgot == true
                                    ? GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    ForgotpasswordScreenView()),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Container(
                                            width: 55,
                                            color: Colors.transparent,
                                            child: Center(
                                              child: Text(
                                                AppConstants.forGotText,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xffA13FF5)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isTapShow = !isTapShow;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Image.asset(
                                            isTapShow == false
                                                ? ImagePath.hidePassword
                                                : ImagePath.showPassword,
                                            height: 22,
                                            width: 22,
                                          ),
                                        ),
                                      ),
                                hintText: "Enter Your Password",
                                hintStyle: hintFieldTextStyle),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Material(
                              type: MaterialType.transparency,
                              elevation: 10,
                              animationDuration: Duration(seconds: 1),
                              child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      check1 = !check1;
                                      dontcheck = false;
                                      log(check1.toString());
                                    });
                                  },
                                  child: check1
                                      ? Container(
                                          alignment: Alignment.center,
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Color(0xffA13FF5),
                                            border: Border.all(
                                                color: Color(0xffA13FF5)),
                                          ),
                                          child: Image.asset(
                                            ImagePath.checkmark,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                        )),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    check1 = !check1;
                                    dontcheck = false;
                                    log(check1.toString());
                                  });
                                },
                                child: RichText(
                                  textAlign: TextAlign.start,
                                  maxLines: 3,
                                  text: TextSpan(
                                    text: AppConstants.readAccept,
                                    style: regularRichStyle,
                                    children: [
                                      TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        PrivacyPolicyScreenView()));
                                          },
                                        text: AppConstants.privacyPolicy,
                                        style: TextStyle(
                                            color: Color(0xffA13FF5),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      TextSpan(text: AppConstants.andAgree),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    check2 = !check2;
                                  });
                                  log(check2.toString());
                                },
                                child: check2
                                    ? Container(
                                        alignment: Alignment.center,
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Color(0xffA13FF5),
                                          border: Border.all(
                                              color: Color(0xffA13FF5)),
                                        ),
                                        child: Image.asset(
                                          ImagePath.checkmark,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border:
                                                Border.all(color: Colors.grey)),
                                      )),
                            SizedBox(width: 8),
                            Flexible(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    check2 = !check2;
                                  });
                                },
                                child: RichText(
                                  textAlign: TextAlign.start,
                                  maxLines: 3,
                                  text: TextSpan(
                                    text: AppConstants.readAccept,
                                    style: regularRichStyle,
                                    children: [
                                      TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        TermScreenView()));
                                          },
                                        text: AppConstants.termsofUse,
                                        style: TextStyle(
                                            color: Color(0xffA13FF5),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: CommonButton(
                            btnName: AppConstants.login,
                            btnOnTap: () {
                              if (formKey.currentState!.validate()) {
                                if (check1 == true && check2 == true) {
                                  checkConnection();
                                } else if (check1 == false) {
                                  Fluttertoast.showToast(
                                      msg: "Please Accept Privacy Policy");
                                } else if (check2 == false) {
                                  Fluttertoast.showToast(
                                      msg: "Please Accept Terms of Use");
                                } else {}
                              }
                            }),
                      ),
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
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
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
                      SizedBox(height: 20),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(
                          color: Color(0xff5C5C65).withOpacity(.20),
                        ),
                      ),
                      child: Row(
                        children: [
                          Spacer(),
                          Image.asset(ImagePath.google, height: 22, width: 22),
                          SizedBox(width: 10),
                          Text(
                            AppConstants.google,
                            style: TextStyle(
                                color: Color(0xff646B7B),
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(
                          color: Color(0xff5C5C65).withOpacity(.20),
                        ),
                      ),
                      child: Row(
                        children: [
                          Spacer(),
                          Image.asset(ImagePath.apple, height: 22, width: 22),
                          SizedBox(width: 10),
                          Text(
                            AppConstants.apple,
                            style: TextStyle(
                                color: Color(0xff646B7B),
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
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
      loginAPI();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      loginAPI();
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

  loginAPI() async {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    CommonUtils.showProgressLoading(context);
    try {
      var params = {
        "email": mailController.text,
        "mobile_number": "",
        "password": passwordController.text,
      };
      log("Login Params ::::::$params");
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
        dioClient.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      };
      var response = await dio.post(LOGIN_URl, data: jsonEncode(params));
      log("Login Respnse::::::${response.data}");
      if (response.statusCode == 200) {
        if (response.data["status"] == "success") {
          CommonUtils.hideProgressLoading(context);
          setState(() {
            loginModel = LoginModel.fromJson((response.data));
          });
          showDialog<String>(
              context: context,
              builder: (BuildContext context) => StatefulBuilder(
                    builder: (BuildContext context,
                        void Function(void Function()) setState) {
                      return WarningView(
                        fromValue: "Login",
                      );
                    },
                  ));
          pref.setString(USER_TOKEN, loginModel!.token.toString());
        } else if (response.data["status"] == "error") {
          CommonUtils.hideProgressLoading(context);
          Fluttertoast.showToast(msg: "Enter Correct Login Email Or Password");
        }
      } else {
        CommonUtils.hideProgressLoading(context);
        Fluttertoast.showToast(msg: loginModel!.message.toString());
      }
    } on DioError catch (e) {
      log("Login error $e");
    }
  }
}
