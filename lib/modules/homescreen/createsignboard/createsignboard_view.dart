// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signboard/Core/Constant/value_constants.dart';
import 'package:signboard/modules/homescreen/createsignboard/addgifscreen/addgif_view.dart';
import 'package:signboard/modules/homescreen/createsignboard/addgifscreen/primegif_view.dart';
import 'package:signboard/modules/homescreen/createsignboard/addimagescreen/addimage_view.dart';
import 'package:signboard/modules/homescreen/createsignboard/addtextscreen/addtext_view.dart';
import 'package:signboard/modules/homescreen/createsignboard/addvideoscreen/addvideo_view.dart';
import 'package:signboard/modules/homescreen/createsignboard/addvideoscreen/primevideo_view.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/utils/image_path_constants.dart';
import 'package:signboard/utils/text_styles.dart';
import 'package:signboard/widgets/commonappbar.dart';
import 'package:signboard/widgets/submit_button.dart';

class CreateSignBoardScreenView extends StatefulWidget {
  const CreateSignBoardScreenView({super.key});

  @override
  State<CreateSignBoardScreenView> createState() =>
      _CreateSignBoardScreenViewState();
}

class _CreateSignBoardScreenViewState extends State<CreateSignBoardScreenView> {
  String? userToken;

  getPrefData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userToken = pref.getString(USER_TOKEN);
    log("user Token ::::: $userToken");
  }

  @override
  void initState() {
    super.initState();
    getPrefData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CommonAppbar(
              name: AppConstants.createSignboard,
              centerTitleText: false,
              color: Colors.transparent,
              onClick: () {
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Container(
                    height: 394,
                    width: width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffE3E6E9),
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        AppConstants.signboardPreview,
                        style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffE0E2E5)),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    AppConstants.selectOption,
                    style: regularHeadingStyle,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // text
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => const AddTextScreenView(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xffDDE0E4).withOpacity(.8),
                                ),
                              ),
                              child: Center(
                                child: Image.asset(ImagePath.textImage,
                                    height: 28, width: 28),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              AppConstants.text,
                              style: regularHeadingStyle.copyWith(
                                  color: Color(0xff676C77), fontSize: 13),
                            ),
                          ],
                        ),
                      ),

                      // images
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => const AddImageScreenView(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color:
                                          Color(0xffDDE0E4).withOpacity(.8))),
                              child: Center(
                                child: Image.asset(ImagePath.imagesImage,
                                    height: 28, width: 28),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              AppConstants.images,
                              style: regularHeadingStyle.copyWith(
                                  color: Color(0xff676C77), fontSize: 13),
                            ),
                          ],
                        ),
                      ),

                      // gifs
                      GestureDetector(
                        onTap: () {
                          /* showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  StatefulBuilder(
                                    builder: (BuildContext context,
                                        void Function(void Function())
                                            setState) {
                                      return PrimePopUpGifScreenView();
                                    },
                                  )); */
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => const AddGifScreenView(),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 65,
                                  width: 65,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Color(0xffDDE0E4)
                                              .withOpacity(.8))),
                                  child: Center(
                                    child: Image.asset(ImagePath.gifsImage,
                                        height: 28, width: 28),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  AppConstants.gifs,
                                  style: regularHeadingStyle.copyWith(
                                      color: Color(0xff676C77), fontSize: 13),
                                ),
                              ],
                            ),
                            /* Positioned(
                              right: 0,
                              top: -10,
                              child: Image.asset(
                                ImagePath.primeImage,
                                height: 29,
                                width: 29,
                              ),
                            ), */
                          ],
                        ),
                      ),

                      // videos
                      GestureDetector(
                        onTap: () {
                          /* showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  StatefulBuilder(
                                    builder: (BuildContext context,
                                        void Function(void Function())
                                            setState) {
                                      return PrimePopUpVideoScreenView();
                                    },
                                  )); */
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => const AddVideoScreenView(),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 65,
                                  width: 65,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Color(0xffDDE0E4)
                                              .withOpacity(.8))),
                                  child: Center(
                                    child: Image.asset(ImagePath.videosImage,
                                        height: 28, width: 28),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  AppConstants.videos,
                                  style: regularHeadingStyle.copyWith(
                                      color: Color(0xff676C77), fontSize: 13),
                                ),
                              ],
                            ),
                            /* Positioned(
                              right: 0,
                              top: -10,
                              child: Image.asset(
                                ImagePath.primeImage,
                                height: 29,
                                width: 29,
                              ),
                            ), */
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 35),
                  /* CommonButton(
                      btnName: AppConstants.addInformation, btnOnTap: () {}),
                  SizedBox(height: 15), */
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
