// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/utils/image_path_constants.dart';
import 'package:signboard/utils/text_styles.dart';
import 'package:signboard/widgets/submit_button.dart';

class PrimePopUpVideoScreenView extends StatefulWidget {
  const PrimePopUpVideoScreenView({super.key});

  @override
  State<PrimePopUpVideoScreenView> createState() =>
      _PrimePopUpVideoScreenViewState();
}

class _PrimePopUpVideoScreenViewState extends State<PrimePopUpVideoScreenView> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.only(left: 0, right: 0),
      content: Container(
        height: 500,
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
                    "",
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
              SizedBox(height: 20),
              Image.asset(ImagePath.premium, height: 176),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Text(
                  AppConstants.preminumVideo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff626E79),
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Text(
                  AppConstants.preminumVideoAmount,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff848CA1),
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 54,
                  decoration: BoxDecoration(
                    color: const Color(0xffA13FF5),
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 0,
                        blurRadius: 24,
                        offset: const Offset(0, 14),
                        color: const Color(0xffA13FF5).withOpacity(.3),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: RichText(
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    text: TextSpan(
                      text: AppConstants.videoPayAmount,
                      style: regularRichStyle.copyWith(
                          color: Color(0xffF6F7FB),
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        
                                        Navigator.pop(context);
                                      },
                            text: AppConstants.perVideoText,
                            style: TextStyle(
                                color: Color(0xffF6F7FB).withOpacity(.9),
                                fontSize: 12,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  color: Colors.transparent,
                  child: Text(
                    AppConstants.doLatter,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xff636978),
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
