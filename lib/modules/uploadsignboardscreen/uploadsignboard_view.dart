// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, must_be_immutable, deprecated_member_use, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signboard/Core/Constant/CommonUtils.dart';
import 'package:signboard/Core/Constant/url_constant.dart';
import 'package:signboard/Core/Constant/value_constants.dart';
import 'package:signboard/modules/countryscreen/country_view.dart';
import 'package:signboard/modules/homescreen/home_view.dart';
import 'package:signboard/modules/provincescreen/province_view.dart';
import 'package:signboard/modules/uploadsignboardscreen/sendnotificationscreen/sendnotification_view.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/utils/image_path_constants.dart';
import 'package:signboard/utils/text_styles.dart';
import 'package:signboard/widgets/commentextfield.dart';
import 'package:signboard/widgets/commonappbar.dart';
import 'package:signboard/widgets/submit_button.dart';
import 'package:signboard/widgets/text.dart';
import 'package:video_player/video_player.dart';

class UploadSignboardScreenView extends StatefulWidget {
  String? fromValue;
  String? createPost;
  File? selectedImage;
  String? productImageId;
  String? productTextId;
  String? productVideoId;
  String? productGifId;
  VideoPlayerController? videoPlayerController;
  String? pickTextImage;

  UploadSignboardScreenView(
      {super.key,
      this.fromValue,
      this.createPost,
      this.selectedImage,
      this.productImageId,
      this.productTextId,
      this.productVideoId,
      this.productGifId,
      this.videoPlayerController,
      this.pickTextImage});

  @override
  State<UploadSignboardScreenView> createState() =>
      _UploadSignboardScreenViewState();
}

class _UploadSignboardScreenViewState extends State<UploadSignboardScreenView> {
  var result;
  String? selectedImage;
  String? selectName;
  String? selectCountryCode;
  bool check1 = false;
  bool check2 = false;
  bool dontcheck = false;
  String? userToken;
  TextEditingController mobileController = TextEditingController();
  TextEditingController wpNumberController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController keyWordController = TextEditingController();

  getPrefData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userToken = pref.getString(USER_TOKEN);
    log("user Token ::::: $userToken");
    log("FromValue ::::: ${widget.fromValue}");
  }

  @override
  void initState() {
    super.initState();
    getPrefData();
    log("textProdcutId :::;; ${widget.productTextId}");
    log("videoProdcutId :::;; ${widget.productVideoId}");
    log("videoProdcutId :::;; ${widget.productVideoId}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CommonAppbar(
                name: AppConstants.uploadSignboardText,
                centerTitleText: false,
                color: Colors.transparent,
                onClick: () {
                  /* Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(
                        builder: (context) => const HomeScreenView(),
                      ),
                      (route) => false); */
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: widget.fromValue == "IMAGE"
                          ? ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              child: Image.file(
                                File(widget.selectedImage!.path),
                                fit: BoxFit.cover,
                                height: 394,
                              ),
                            )
                          : widget.fromValue == "TEXT"
                              ? Image.file(
                                  File(widget.pickTextImage.toString()),
                                  fit: BoxFit.cover,
                                )
                              : widget.fromValue == "VIDEO"
                                  ? AspectRatio(
                                      aspectRatio: widget.videoPlayerController!
                                          .value.aspectRatio,
                                      child: VideoPlayer(
                                          widget.videoPlayerController!),
                                    )
                                  : widget.fromValue == "GIF"
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          child: Image.file(
                                            File(widget.selectedImage!.path),
                                            fit: BoxFit.cover,
                                            height: 394,
                                          ),
                                        )
                                      : Container(),
                    ),
                    /* SizedBox(height: 10),
                    CommonText(text: AppConstants.signboardName),
                    SizedBox(height: 10),
                    CommonTextField(
                      controller: nameController,
                      hinttext: AppConstants.signboardName,
                      padding: 0,
                      readonly: false,
                      textInputaction: TextInputAction.next,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(ImagePath.reachSelect,
                            height: 22, width: 22),
                      ),
                      isObsecure: false,
                    ),
                    SizedBox(height: 10),
                    CommonText(text: AppConstants.signboardDec),
                    SizedBox(height: 10),
                    CommonTextField(
                      controller: desController,
                      hinttext: AppConstants.signboardDec,
                      padding: 0,
                      readonly: false,
                      textInputaction: TextInputAction.next,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(ImagePath.signboardDesImage,
                            height: 22, width: 22),
                      ),
                      isObsecure: false,
                    ),
                    SizedBox(height: 10),
                    CommonText(text: AppConstants.startDate),
                    SizedBox(height: 10),
                    Container(
                      height: 55,
                      color: Colors.transparent,
                      child: TextFormField(
                        controller: startDateController,
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
                            hintText: AppConstants.startDate,
                            hintStyle: hintTextStyle.copyWith(fontSize: 12)),
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
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101));
                          startDateController.text =
                              DateFormat('dd-MM-yyyy').format(pickedDate!);
                          log("startDateController:::::::${startDateController.text}");
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    CommonText(text: AppConstants.endDate),
                    SizedBox(height: 10),
                    Container(
                      height: 55,
                      color: Colors.transparent,
                      child: TextFormField(
                        controller: endDateController,
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
                            hintText: AppConstants.endDate,
                            hintStyle: hintTextStyle.copyWith(fontSize: 12)),
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
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101));
                          endDateController.text =
                              DateFormat('dd-MM-yyyy').format(pickedDate!);
                          log("endDateController:::::::${endDateController.text}");
                        },
                      ),
                    ),
                     */
                    SizedBox(height: 15),
                    CommonText(text: AppConstants.country),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        result = await Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => const CountryScreenView(),
                          ),
                        );
                        log("result : ${result['image']}");
                        if (result != null) {
                          setState(() {
                            selectedImage = result['image'];
                            selectName = result['text'];
                            selectCountryCode = result['iso2'];
                          });
                        }
                        log("select Image  $selectedImage");
                        log("select Name  $selectName");
                        log("select Name  $selectCountryCode");
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
                                  child: Text(
                                    selectName != null
                                        ? selectName.toString()
                                        : "Your Country",
                                    /* style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600), */
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
                    ),
                    SizedBox(height: 10),
                    CommonText(text: AppConstants.province),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                         Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => ProvinceScreenView(countryCode: selectCountryCode,),
                          ),
                        );
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
                            Row(
                              children: [
                                Image.asset(ImagePath.reachSelect,
                                    height: 22, width: 22),
                                SizedBox(width: 8),
                                Text(AppConstants.rajsthanText),
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
                    ),
                    SizedBox(height: 10),
                    CommonText(text: AppConstants.number),
                    SizedBox(height: 10),
                    CommonTextField(
                      controller: mobileController,
                      hinttext: AppConstants.number,
                      padding: 0,
                      textInputType: TextInputType.phone,
                      textInputaction: TextInputAction.next,
                      textInputFormatter: [
                        LengthLimitingTextInputFormatter(13),
                      ],
                      readonly: false,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(ImagePath.number,
                            height: 22, width: 22),
                      ),
                      isObsecure: false,
                    ),
                    SizedBox(height: 10),
                    CommonText(text: AppConstants.wpWithCc),
                    SizedBox(height: 10),
                    CommonTextField(
                      controller: wpNumberController,
                      hinttext: AppConstants.wpWithCc,
                      padding: 0,
                      textInputType: TextInputType.number,
                      textInputFormatter: [
                        LengthLimitingTextInputFormatter(10)
                      ],
                      readonly: false,
                      textInputaction: TextInputAction.next,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(ImagePath.whatsAppImage,
                            height: 22, width: 22),
                      ),
                      isObsecure: false,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        CommonText(text: AppConstants.webUrlText),
                        SizedBox(width: 3),
                        Text(
                          AppConstants.optionalText,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff8186A1).withOpacity(.7)),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    CommonTextField(
                      controller: urlController,
                      hinttext: AppConstants.webUrlText,
                      padding: 0,
                      readonly: false,
                      textInputaction: TextInputAction.next,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(ImagePath.urlImage,
                            height: 22, width: 22),
                      ),
                      isObsecure: false,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        CommonText(text: AppConstants.emailText),
                        SizedBox(width: 3),
                        Text(
                          AppConstants.optionalText,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff8186A1).withOpacity(.7)),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    CommonTextField(
                      controller: emailController,
                      hinttext: AppConstants.emailText,
                      padding: 0,
                      readonly: false,
                      textInputaction: TextInputAction.next,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child:
                            Image.asset(ImagePath.email, height: 22, width: 22),
                      ),
                      isObsecure: false,
                    ),
                    SizedBox(height: 10),
                    CommonText(text: AppConstants.tagKeyText),
                    SizedBox(height: 10),
                    Container(
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
                      ),
                      child: TextFormField(
                        controller: keyWordController,
                        maxLines: 5,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: BorderSide.none
                              // borderSide: BorderSide(color: Color(0xffD1D1D1), width: 1.5),
                              ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none
                              // borderSide: BorderSide(color: Color(0xffD1D1D1), width: 1.5),
                              ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none
                              // borderSide: BorderSide(color: Colors.red)
                              ),
                          hintText: AppConstants.keyText,
                          hintStyle: hintTextStyle,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
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
                                        borderRadius: BorderRadius.circular(5),
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
                              child: Text(
                                AppConstants.contentText,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff8186A1),
                                ),
                              )),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    CommonButton(
                      btnName: AppConstants.uploadSignboard,
                      btnOnTap: () {
                        createSignboard();
                      },
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /* uploadProductimage(File selectedImage) async {
    Dio dio = Dio();
    CommonUtils.showProgressLoading(context);
    try {
      FormData formData = FormData.fromMap(
        {"sendimage": selectedImage},
      );
      log("UploadImage Params ::::::$formData");
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
        dioClient.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      };
      var response =
          await dio.post(UPLOADPRODUCT_IMAGE_URl, data: jsonEncode(formData));
      log("Create Signboard Respnse::::::${response.data}");
      if (response.statusCode == 200) {
        if (response.data["status"] == "success") {
          CommonUtils.hideProgressLoading();
          /* setState(() {
            loginModel = LoginModel.fromJson((response.data));
          }); */
        } else if (response.data["status"] == "error") {
          CommonUtils.hideProgressLoading();
          // Fluttertoast.showToast(msg: "Enter Correct Login Email Or Password");
        }
      } else {
        CommonUtils.hideProgressLoading();
        // Fluttertoast.showToast(msg: loginModel!.message.toString());
      }
    } on DioError catch (e) {
      log("Login error $e");
    }
  } */

  createSignboard() async {
    Dio dio = Dio();
    CommonUtils.showProgressLoading(context);
    try {
      var params = {
        "t": "$userToken",
        "signboard_name": "",
        "signboard_desc": "",
        "signboard_category": widget.fromValue == "VIDEO" ? "VIDEO" : "IMAGE",
        "price_type": "Paid",
        "price": "150",
        "startdatetime": "2022-02-13",
        "enddatetime": "2022-02-15",
        "location": "30.18563599999993 21.513096",
        "location_name": "",
        "signboard_image_id": widget.fromValue == "TEXT"
            ? widget.productTextId
            : widget.fromValue == "IMAGE"
                ? widget.productImageId
                : widget.fromValue == "VIDEO"
                    ? widget.productVideoId
                    : widget.fromValue == "GIF"
                        ? widget.productGifId
                        : "",
        "country": selectName,
        "province": "keywords",
        "country_flag": selectedImage,
        "email": emailController.text,
        "signboard_url": urlController.text,
        "callnumber": mobileController.text,
        "whatsapp": wpNumberController.text,
        "keywords": keyWordController.text,
      };
      log("Create Signboard Params ::::::$params");
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
        dioClient.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      };
      var response =
          await dio.post(CREATE_SIGNBOARD_URl, data: jsonEncode(params));
      log("Create Signboard Respnse::::::${response.data}");
      if (response.statusCode == 200) {
        if (response.data["status"] == "success") {
          CommonUtils.hideProgressLoading(context);
          Fluttertoast.showToast(msg: response.data["message"]);
          Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => const SendNotificationScreenView(),
          ));
          Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(
                builder: (context) => const HomeScreenView(),
              ),
              (route) => false);
          /* setState(() {
            loginModel = LoginModel.fromJson((response.data));
          }); */
        } else if (response.data["status"] == "error") {
          CommonUtils.hideProgressLoading(context);
          // Fluttertoast.showToast(msg: "Enter Correct Login Email Or Password");
        }
      } else {
        CommonUtils.hideProgressLoading(context);
        // Fluttertoast.showToast(msg: loginModel!.message.toString());
      }
    } on DioError catch (e) {
      log("Login error $e");
    }
  }
}
