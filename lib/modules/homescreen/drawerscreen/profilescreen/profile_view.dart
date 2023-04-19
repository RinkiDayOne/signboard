// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously, deprecated_member_use, unused_local_variable

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signboard/Core/Constant/CommonUtils.dart';
import 'package:signboard/Core/Constant/url_constant.dart';
import 'package:signboard/Core/Constant/value_constants.dart';
import 'package:signboard/models/get_userdetail_model.dart';
import 'package:signboard/modules/categoryscreen/category_view.dart';
import 'package:signboard/modules/countryscreen/country_view.dart';
import 'package:signboard/modules/homescreen/home_view.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/utils/image_path_constants.dart';
import 'package:signboard/utils/text_styles.dart';
import 'package:signboard/widgets/commentextfield.dart';
import 'package:signboard/widgets/commonappbar.dart';
import 'package:signboard/widgets/submit_button.dart';
import 'package:signboard/widgets/text.dart';

class MyProfileScreenView extends StatefulWidget {
  const MyProfileScreenView({super.key});

  @override
  State<MyProfileScreenView> createState() => _MyProfileScreenViewState();
}

class _MyProfileScreenViewState extends State<MyProfileScreenView> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  List categoryList = [];
  var result;
  GetUserDetailModel? getUserDetailModel;
  String? userToken;
  final formKey = GlobalKey<FormState>();
  String? selectedCategory = "";
  String? occupation;
  String? selectedImage;
  String? selectName;

  getPrefData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userToken = pref.getString(USER_TOKEN);
    log("user Token ::::: $userToken");
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

  @override
  void initState() {
    super.initState();
    checkConnection();
    getPrefData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CommonAppbar(
                name: AppConstants.myProfile,
                centerTitleText: false,
                color: Colors.transparent,
                onClick: () {
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
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
                        isObsecure: false,
                      ),
                      SizedBox(height: 10),
                      CommonText(text: AppConstants.email),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Colors.grey.withOpacity(.5),
                        ),
                        child: CommonTextField(
                            controller: emailController,
                            hinttext: AppConstants.email,
                            padding: 0,
                            readonly: true,
                            textInputaction: TextInputAction.next,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Image.asset(ImagePath.email,
                                  height: 22, width: 22),
                            ),
                            isObsecure: false),
                      ),
                      SizedBox(height: 10),
                      CommonText(text: AppConstants.number),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Colors.grey.withOpacity(.5),
                        ),
                        child: CommonTextField(
                            controller: mobileController,
                            hinttext: AppConstants.number,
                            padding: 0,
                            readonly: true,
                            textInputaction: TextInputAction.next,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Image.asset(ImagePath.number,
                                  height: 22, width: 22),
                            ),
                            isObsecure: false),
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
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: Colors.grey.withOpacity(.5),
                                  ),
                                  child: TextFormField(
                                    controller: dobController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(right: 8),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(13)),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          borderSide: BorderSide(
                                              color: Color(0xffD1D1D1),
                                              width: 1.5),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          borderSide: BorderSide(
                                              color: Color(0xffD1D1D1),
                                              width: 1.5),
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
                                        hintStyle: hintTextStyle.copyWith(
                                            fontSize: 12)),
                                    /* onTap: () async {
                                      DateTime? date = DateTime.now();
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(2101));
                                      dobController.text =
                                          DateFormat('dd-MM-yyyy')
                                              .format(pickedDate!);
                                      log("dobController:::::::${dobController.text}");
                                    }, */
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
                                        color:
                                            Color(0xffC5D0DE).withOpacity(.8),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(width: 8),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            selectedImage != null
                                                ? SvgPicture.network(
                                                    selectedImage.toString(),
                                                    height: 22,
                                                    width: 22,
                                                    fit: BoxFit.fill,
                                                    // color: Colors.yellow,
                                                  )
                                                : Container(),
                                            SizedBox(width: 8),
                                            Container(
                                              child: Text(
                                                selectName != null
                                                    ? selectName.toString()
                                                    : "Your Country",
                                                /* style: hintTextStyle.copyWith(
                                                    fontSize: 14), */
                                              ),
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
                          log(result.toString());
                        },
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
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
                                    Text("Accountant"),
                                    /* Container(
                                        height: 50,
                                        width: width,
                                        color: Colors.transparent,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            return Center(
                                              child: Text(
                                                  result != [] ? result.toString() : "Dhruv"),
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
                          btnName: AppConstants.saveChangesText,
                          btnOnTap: () {
                            if (formKey.currentState!.validate()) {
                              updateUserdetailsAPI();
                            }
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      userdetailsAPI();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      userdetailsAPI();
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

  userdetailsAPI() async {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    CommonUtils.showProgressLoading(context);
    try {
      var params = {"t": "$userToken"};
      log("Userdetails Params ::::::$params");
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
        dioClient.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      };
      var response = await dio.post(GETUSERDATA_URl, data: jsonEncode(params));
      log("Userdetails Respnse::::::${response.data}");
      if (response.statusCode == 200) {
        CommonUtils.hideProgressLoading(context);
        setState(() {
          getUserDetailModel = GetUserDetailModel.fromJson(response.data);
          fullNameController.text =
              getUserDetailModel != null && getUserDetailModel!.data != null
                  ? getUserDetailModel!.data![0].fullname.toString()
                  : "";
          userNameController.text =
              getUserDetailModel != null && getUserDetailModel!.data != null
                  ? getUserDetailModel!.data![0].username.toString()
                  : "";
          emailController.text =
              getUserDetailModel != null && getUserDetailModel!.data != null
                  ? getUserDetailModel!.data![0].email.toString()
                  : "";
          mobileController.text =
              getUserDetailModel != null && getUserDetailModel!.data != null
                  ? getUserDetailModel!.data![0].mobileNumber.toString()
                  : "";
          dobController.text =
              getUserDetailModel != null && getUserDetailModel!.data != null
                  ? getUserDetailModel!.data![0].dob.toString()
                  : "";
          selectedCategory =
              getUserDetailModel != null && getUserDetailModel!.data != null
                  ? getUserDetailModel!.data![0].category.toString()
                  : "";
          selectedImage =
              getUserDetailModel != null && getUserDetailModel!.data != null
                  ? getUserDetailModel!.data![0].flag.toString()
                  : "";
          selectName =
              getUserDetailModel != null && getUserDetailModel!.data != null
                  ? getUserDetailModel!.data![0].country.toString()
                  : "";
        });
        log("User Name ::::: ${getUserDetailModel!.data![0].username.toString()}");
        
      } else {
        CommonUtils.hideProgressLoading(context);
      }
    } on DioError catch (e) {
      log("Userdetails error $e");
    }
  }

  updateUserdetailsAPI() async {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    CommonUtils.showProgressLoading(context);
    try {
      var params = {
        "t": "$userToken",
        "username": userNameController.text,
        "fullname": fullNameController.text,
        "email": emailController.text,
        "mobile_number": mobileController.text,
        "dob": dobController.text /* "1990-12-25" */,
        "country": selectName,
        "category": selectedCategory
      };
      log("UpdateUserdetails Params ::::::$params");
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
        dioClient.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      };
      var response =
          await dio.put(UPDATEUSERDATA_URl, data: jsonEncode(params));
      log("UpdateUserdetails Respnse::::::${response.data}");
      if (response.statusCode == 200) {
        setState(() {});
        Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(
              builder: (context) => const HomeScreenView(),
            ),
            (route) => false);
        CommonUtils.hideProgressLoading(context);
      } else {
        CommonUtils.hideProgressLoading(context);
      }
    } on DioError catch (e) {
      log("UpdateUserdetails error $e");
    }
  }
}
