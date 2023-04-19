// ignore_for_file: prefer_const_constructors, unused_local_variable, use_build_context_synchronously, deprecated_member_use

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signboard/Core/Constant/CommonUtils.dart';
import 'package:signboard/Core/Constant/url_constant.dart';
import 'package:signboard/Core/Constant/value_constants.dart';
import 'package:signboard/models/register_model.dart';
import 'package:signboard/modules/categoryscreen/category_view.dart';
import 'package:signboard/modules/countryscreen/country_view.dart';
import 'package:signboard/modules/loginscreen/login_view.dart';
import 'package:signboard/modules/loginscreen/warningscreen/warning_view.dart';
import 'package:signboard/modules/registerscreen/viewbybox/viewby_view.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/utils/image_path_constants.dart';
import 'package:signboard/utils/text_styles.dart';
import 'package:signboard/widgets/commentextfield.dart';
import 'package:signboard/widgets/submit_button.dart';
import 'package:signboard/widgets/text.dart';
import 'package:intl/intl.dart';

class RegisterScreenView extends StatefulWidget {
  /* String? name;
  String? image; */
  RegisterScreenView({
    super.key,
    /* this.image,this.name */
  });

  @override
  State<RegisterScreenView> createState() => _RegisterScreenViewState();
}

class _RegisterScreenViewState extends State<RegisterScreenView> {
  bool isTapShow = false;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  List categoryList = [];
  var result;
  String? selectedImage;
  String? selectName;
  RegisterModel? registerModel;
  String? selectedCategory = "";
  String? occupation;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Center(
                  child: Image.asset(
                    ImagePath.loginLogo,
                    height: 45,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0),
                  child: Text(
                    AppConstants.registerHeading,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff848CA1)),
                  ),
                ),
                SizedBox(height: 20),
                CommonText(text: AppConstants.fullName),
                SizedBox(height: 10),
                CommonTextField(
                    controller: fullNameController,
                    hinttext: AppConstants.fullName,
                    padding: 0,
                    readonly: false,
                    textInputaction: TextInputAction.next,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(ImagePath.fullName,
                          height: 22, width: 22),
                    ),
                    isObsecure: false),
                SizedBox(height: 10),
                CommonText(text: AppConstants.userName),
                SizedBox(height: 10),
                CommonTextField(
                    controller: userNameController,
                    hinttext: AppConstants.userName,
                    padding: 0,
                    readonly: false,
                    textInputaction: TextInputAction.next,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(ImagePath.userName,
                          height: 22, width: 22),
                    ),
                    isObsecure: false),
                SizedBox(height: 10),
                CommonText(text: AppConstants.email),
                SizedBox(height: 10),
                CommonTextField(
                    controller: emailController,
                    hinttext: AppConstants.email,
                    padding: 0,
                    readonly: false,
                    textInputaction: TextInputAction.next,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child:
                          Image.asset(ImagePath.email, height: 22, width: 22),
                    ),
                    isObsecure: false),
                SizedBox(height: 10),
                CommonText(text: AppConstants.number),
                SizedBox(height: 10),
                CommonTextField(
                    controller: mobileController,
                    hinttext: AppConstants.number,
                    padding: 0,
                    readonly: false,
                    textInputType: TextInputType.phone,
                    textInputaction: TextInputAction.next,
                    textInputFormatter: [
                      LengthLimitingTextInputFormatter(13),
                    ],
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child:
                          Image.asset(ImagePath.number, height: 22, width: 22),
                    ),
                    isObsecure: false),
                SizedBox(height: 10),
                CommonText(text: AppConstants.password),
                SizedBox(height: 10),
                CommonTextField(
                  controller: passwordController,
                  hinttext: AppConstants.password,
                  padding: 0,
                  readonly: false,
                  textInputaction: TextInputAction.next,
                  isObsecure: isTapShow == true ? true : false,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(ImagePath.passwordImage,
                        height: 22, width: 22),
                  ),
                  suffixIcon: GestureDetector(
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
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(text: AppConstants.dob),
                          SizedBox(height: 8),
                          Container(
                            height: 55,
                            color: Colors.transparent,
                            child: TextFormField(
                              controller: dobController,
                              readOnly: true,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(right: 8),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide(
                                        color: Color(0xffD1D1D1), width: 1.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide(
                                        color: Color(0xffD1D1D1), width: 1.5),
                                  ),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Image.asset(
                                      ImagePath.dob,
                                      height: 22,
                                      width: 22,
                                    ),
                                  ),
                                  hintText: AppConstants.dob,
                                  hintStyle:
                                      hintTextStyle.copyWith(fontSize: 12)),
                              /* validator: (startDate) {
                                if (startDate == null || startDate.isEmpty) {
                                  return "Please Input Start Date";
                                } else {
                                  return null;
                                }
                              }, */
                              onTap: () async {
                                DateTime? date = DateTime.now();
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1960),
                                  lastDate: DateTime.now(),
                                );
                                dobController.text =
                                    DateFormat('yyyy-MM-dd' /* 'dd-MM-yyyy' */)
                                        .format(pickedDate!);
                                log("dobController:::::::${dobController.text}");
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 12),
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(text: AppConstants.country),
                          SizedBox(height: 8),
                          GestureDetector(
                            onTap: () async {
                              result = await Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      const CountryScreenView(),
                                ),
                              );
                              log("result : ${result['image']}");
                              if (result != null) {
                                setState(() {
                                  selectedImage = result['image'];
                                  selectName = result['text'];
                                });
                              }
                              log("select Image  $selectedImage");
                              log("select Name  $selectName");
                            },
                            child: Container(
                              height: 55,
                              width: 160,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                border: Border.all(
                                  color: Color(0xffC5D0DE).withOpacity(.8),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 8),
                                  Row(
                                    children: [
                                      selectedImage != null
                                          ? SvgPicture.network(
                                              selectedImage.toString(),
                                              height: 22,
                                              width: 22,
                                            )
                                          : Container(),
                                      SizedBox(width: 8),
                                      Container(
                                        child: Text(selectName != null
                                            ? selectName.toString()
                                            : "Your Country",style: hintTextStyle.copyWith(fontSize: 14),),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Image.asset(
                                    ImagePath.rightIcon,
                                    height: 22,
                                    width: 22,
                                  ),
                                  SizedBox(width: 8),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                CommonText(text: AppConstants.category),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    // height: MediaQuery.of(context).size.height * 0.1,
                    // width: MediaQuery.of(context).size.width * 0.89,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(
                        color: Color(0xffC5D0DE).withOpacity(.8),
                      ),
                    ),
                    child: TextFormField(
                      controller: TextEditingController(
                        text: selectedCategory,
                      ),
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: AppConstants.category,
                        hintStyle: hintTextStyle.copyWith(fontSize: 14),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                            ImagePath.rightIcon,
                            height: 22,
                            width: 22,
                          ),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(ImagePath.category,
                              height: 22, width: 22),
                        ),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        _selectitem(context);
                      },
                      onSaved: (val) {
                        occupation = val;
                      },
                    ),
                  ),
                ),
                /* GestureDetector(
                  onTap: () async {
                    result = await Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => const CategoryScreenView(),
                      ),
                    );
                    log("Category ::::::: ${result.toString()}");
                    setState(() {
                      selectedCategory = result;
                    });
                  },
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(
                        color: Color(0xffC5D0DE).withOpacity(.8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 8),
                        Expanded(
                          child: Row(
                            children: [
                              Image.asset(ImagePath.category,
                                  height: 22, width: 22),
                              SizedBox(width: 8),
                              Text(selectedCategory!.isNotEmpty ? selectedCategory.toString() : "Dhruv"),
                              /* Container(
                                  height: 50,
                                  width: width,
                                  color: Colors.transparent,
                                  child: ListView.builder(
                                    itemCount: 1,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Center(
                                        child: Container(
                                          height: 50,
                                          width: 100,
                                          child: Text(
                                              result != [] ? result[0] : "Dhruv"),
                                        ),
                                      );
                                    },
                                  )), */
                            ],
                          ),
                        ),
                        Spacer(),
                        Image.asset(
                          ImagePath.rightIcon,
                          height: 22,
                          width: 22,
                        ),
                        SizedBox(width: 8),
                      ],
                    ),
                  ),
                ), */
                SizedBox(height: 30),
                CommonButton(
                    btnName: AppConstants.continueText,
                    btnOnTap: () {
                      checkConnection();
                      /* showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => StatefulBuilder(
                                builder: (BuildContext context,
                                    void Function(void Function()) setState) {
                                  return ViewByScreen();
                                },
                              )); */
                    }),
                SizedBox(height: 20),
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
                            style: TextStyle(
                                color: Color(0xffA13FF5),
                                fontSize: 12,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectitem(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoryScreenView()),
    );
    if (result != null) {
      setState(() {
        selectedCategory = result;
      });
    }
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      registerAPI();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      registerAPI();
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

  registerAPI() async {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    CommonUtils.showProgressLoading(context);
    try {
      var params = {
        "username": userNameController.text,
        "fullname": fullNameController.text,
        "email": emailController.text,
        "mobile_number": mobileController.text,
        "password": passwordController.text,
        "dob": dobController.text,
        "country": selectName,
        "category": selectedCategory,
      };
      log("register Params ::::::$params");
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
        dioClient.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      };
      var response = await dio.post(REGISTER_URl, data: jsonEncode(params));
      log("Register Respnse::::::${response.data}");
      if (response.statusCode == 200) {
        CommonUtils.hideProgressLoading(context);
        setState(() {
          registerModel = RegisterModel.fromJson((response.data));
        });
        pref.setString(USER_TOKEN, registerModel!.data!.token.toString());
        // pref.setBool(SHOWREGISTER, true);
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => StatefulBuilder(
                  builder: (BuildContext context,
                      void Function(void Function()) setState) {
                    return WarningView(
                      fromValue: "Register",
                    );
                  },
                ));
        // pref.setBool(SHOWLOGIN, true);
        // pref.setString(USER_TOKEN, loginModel!.token.toString());
      } else {
        CommonUtils.hideProgressLoading(context);
        Fluttertoast.showToast(msg: "");
      }
    } on DioError catch (e) {
      log("Login error $e");
    }
  }
}
