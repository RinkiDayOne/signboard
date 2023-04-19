// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/utils/image_path_constants.dart';
import 'package:signboard/widgets/submit_button.dart';

class FilterScreenView extends StatefulWidget {
  const FilterScreenView({super.key});

  @override
  State<FilterScreenView> createState() => _FilterScreenViewState();
}

class _FilterScreenViewState extends State<FilterScreenView> {
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
        height: 315,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 22,
                    width: 22,
                    color: Colors.transparent,
                  ),
                  Spacer(),
                  Text(
                    AppConstants.viewBy,
                    style: TextStyle(
                        color: Color(0xff2C3E50),
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
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
              SizedBox(height: 35),
              GestureDetector(
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Color(0xffC5D0DE).withOpacity(.8)),
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
                            AppConstants.indiaText,
                            style: TextStyle(
                                color: Color(0xff61667C),
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
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
              SizedBox(height: 15),
              GestureDetector(
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Color(0xffC5D0DE).withOpacity(.8)),
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
                                Colors.grey, BlendMode.srcATop),
                            child: Image.asset(
                              ImagePath.provinceImage,
                              height: 22,
                              width: 22,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            AppConstants.rajsthanText,
                            style: TextStyle(
                                color: Color(0xff61667C),
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 35),
              CommonButton(btnName: AppConstants.applyFilter, btnOnTap: () {}),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
