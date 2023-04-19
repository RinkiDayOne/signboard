// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/utils/image_path_constants.dart';
import 'package:signboard/widgets/commentextfield.dart';
import 'package:signboard/widgets/commonappbar.dart';
import 'package:signboard/widgets/submit_button.dart';
import 'package:signboard/widgets/text.dart';

class PaymentScreenView extends StatefulWidget {
  const PaymentScreenView({super.key});

  @override
  State<PaymentScreenView> createState() => _PaymentScreenViewState();
}

class _PaymentScreenViewState extends State<PaymentScreenView> {
  bool isTapVisa = true;
  bool isTapCrypto = false;
  bool isTapMobile = false;
  TextEditingController promoCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
        child: CommonButton(
          btnName: AppConstants.payNow,
          btnOnTap: () {},
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonAppbar(
            name: AppConstants.payForSignboard,
            centerTitleText: false,
            color: Colors.transparent,
            onClick: () {
              Navigator.pop(context);
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    CommonText(text: AppConstants.totalAmount),
                    SizedBox(height: 10),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                          color: Color(0xffD0D0D2).withOpacity(.46),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 10),
                          Text(
                            AppConstants.freeText,
                            style: TextStyle(
                              color: Color(0xff2E383E),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          Text(
                            AppConstants.forOneMonth,
                            style: TextStyle(
                              color: Color(0xff5A585B),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    CommonText(text: AppConstants.payVia),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              (isTapVisa == true)
                                  ? Image.asset(
                                      ImagePath.greenMark,
                                      height: 26,
                                      width: 26,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isTapVisa = true;
                                    isTapCrypto = false;
                                    isTapMobile = false;
                                  });
                                },
                                child: Container(
                                  height: 101,
                                  width: 105,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Color(0xffE7EAE9),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        ImagePath.visa,
                                        height: 19,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        AppConstants.debitCredit,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xff333F52),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          flex: 1,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              (isTapCrypto == true)
                                  ? Image.asset(
                                      ImagePath.greenMark,
                                      height: 26,
                                      width: 26,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isTapVisa = false;
                                    isTapCrypto = true;
                                    isTapMobile = false;
                                  });
                                },
                                child: Container(
                                  height: 101,
                                  width: 105,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Color(0xffE7EAE9),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        ImagePath.crypto,
                                        height: 28,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        AppConstants.crypto,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xff333F52),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          flex: 1,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              (isTapMobile == true)
                                  ? Image.asset(
                                      ImagePath.greenMark,
                                      height: 26,
                                      width: 26,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isTapVisa = false;
                                    isTapCrypto = false;
                                    isTapMobile = true;
                                  });
                                },
                                child: Container(
                                  height: 101,
                                  width: 105,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Color(0xffE7EAE9),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        ImagePath.mobileMoney,
                                        height: 28,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        AppConstants.mobileMoney,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xff333F52),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 3,
                decoration:
                    BoxDecoration(color: Color(0xffCFD0D8).withOpacity(.30)),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(text: AppConstants.enterPromoCode),
                    SizedBox(height: 15),
                    CommonTextField(
                      controller: promoCodeController,
                      hinttext: AppConstants.enterPromoCode,
                      padding: 0,
                      readonly: false,
                      textInputaction: TextInputAction.done,
                      isObsecure: false,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(
                          ImagePath.promoCode,
                          height: 22,
                          width: 22,
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          AppConstants.applyPromoCode,
                          style: TextStyle(
                              color: Color(0xffA13FF5),
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
