// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:signboard/modules/homescreen/home_view.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/utils/image_path_constants.dart';
import 'package:signboard/widgets/submit_button.dart';

class ViewByScreen extends StatefulWidget {
  const ViewByScreen({super.key});

  @override
  State<ViewByScreen> createState() => _ViewByScreenState();
}

class _ViewByScreenState extends State<ViewByScreen> {
  bool isTapPost = false;
  bool isTapContry = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.only(left: 20, right: 20),
      content: Container(
        height: 300,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(
                AppConstants.viewBy,
                style: TextStyle(
                    color: Color(0xff2C3E50),
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 35),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isTapPost = true;
                    isTapContry = false;
                  });
                },
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: isTapPost == true
                            ? Colors.green
                            : Color(0xffC5D0DE).withOpacity(.8)),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 8),
                          ColorFiltered(
                            colorFilter: ColorFilter.mode(
                                isTapPost == true ? Colors.green : Colors.grey,
                                BlendMode.srcATop),
                            child: Image.asset(
                              ImagePath.allPostImage,
                              height: 22,
                              width: 22,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            AppConstants.viewAllPost,
                            style: TextStyle(
                                color: Color(0xff61667C),
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: isTapPost == true
                                ? Colors.green
                                : Colors.transparent,
                            shape: BoxShape.circle),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isTapContry = true;
                    isTapPost = false;
                  });
                },
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: isTapContry == true
                            ? Colors.green
                            : Color(0xffC5D0DE).withOpacity(.8)),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 8),
                          Image.asset(
                            ImagePath.indiaImage,
                            height: 22,
                            width: 22,
                          ),
                          SizedBox(width: 10),
                          Text(
                            AppConstants.viewByCountry,
                            style: TextStyle(
                                color: Color(0xff61667C),
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: isTapContry == true
                                ? Colors.green
                                : Colors.transparent,
                            shape: BoxShape.circle),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 35),
              CommonButton(
                  btnName: AppConstants.continueText,
                  btnOnTap: () {
                    if (isTapContry == true) {
                      log("select country :::::: $isTapContry");
                    } else if (isTapPost == true) {
                      log("select post :::::: $isTapPost");
                    }
                    Navigator.of(context).pushAndRemoveUntil(
                        CupertinoPageRoute(
                          builder: (context) => const HomeScreenView(),
                        ),
                        (route) => false);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
