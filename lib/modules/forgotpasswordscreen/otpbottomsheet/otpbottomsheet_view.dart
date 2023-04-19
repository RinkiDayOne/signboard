// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:signboard/modules/forgotpasswordscreen/newpasswordscreen/newpassword_view.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/widgets/submit_button.dart';

class OtpBottomSheetView extends StatefulWidget {
  String? email;
  OtpBottomSheetView({super.key, this.email});

  @override
  State<OtpBottomSheetView> createState() => _OtpBottomSheetViewState();
}

class _OtpBottomSheetViewState extends State<OtpBottomSheetView> {
  TextEditingController otpController = TextEditingController();
  var otp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            height: 370,
            // MediaQuery.of(context).size.height * 0.95,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          AppConstants.verifyOtp,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff2C3E50),
                              fontSize: 17),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.email != null
                                ? "${AppConstants.otpOnEmail} ${widget.email!.toString().replaceRange(3, widget.email!.indexOf("@"), "****")} ,${AppConstants.verifyMail}"
                                : "",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff848CA1)),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Pinput(
                        controller: otpController,
                        length: 4,
                        cursor: Container(
                          height: 19.87,
                          width: 2,
                          color: Color(0xff57606F).withOpacity(0.1),
                        ),
                        showCursor: true,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        submittedPinTheme: PinTheme(
                          width: 54,
                          height: 50,
                          textStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w400),
                          decoration: BoxDecoration(
                            color: Color(0xffA13FF5),
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                        focusedPinTheme: PinTheme(
                          width: 54,
                          height: 50,
                          textStyle: TextStyle(color: Colors.white),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 19,
                                  color: Color(0xff051B28).withOpacity(.09),
                                  offset: Offset(5.0, 5.0))
                            ],
                            color: Colors.white,
                            border: Border.all(
                              color: Color(0xff79244D).withOpacity(0.23),
                            ),
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                        defaultPinTheme: PinTheme(
                          width: 54,
                          height: 50,
                          textStyle: TextStyle(color: Colors.white),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Color(0xff79244D).withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: AppConstants.didNotCode,
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Color(0xff777777),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            ),
                            /* TextStyle(color: Color(0xff777777)), */
                            children: <TextSpan>[
                              TextSpan(
                                  text: AppConstants.resendNow,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                    },
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Color(0xffA13FF5),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  )
                                  ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    CommonButton(
                      btnName: AppConstants.verifyNow,
                      btnOnTap: () {
                        log("Otp :::::: ${otpController.text}");
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                              builder: (context) => NewPassWordScreenView(
                                    emailText: widget.email,
                                    otptext: otpController.text,
                                  )),
                        );
                        // Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
