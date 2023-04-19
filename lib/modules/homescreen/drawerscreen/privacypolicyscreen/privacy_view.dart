// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/widgets/commonappbar.dart';
import 'package:signboard/widgets/text.dart';

class PrivacyPolicyScreenView extends StatefulWidget {
  const PrivacyPolicyScreenView({super.key});

  @override
  State<PrivacyPolicyScreenView> createState() =>
      _PrivacyPolicyScreenViewState();
}

class _PrivacyPolicyScreenViewState extends State<PrivacyPolicyScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonAppbar(
              name: AppConstants.privacy,
              centerTitleText: false,
              color: Colors.transparent,
              onClick: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        AppConstants.privacyPolicy,
                        style: TextStyle(
                            color: Color(0xff333F52),
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Text(
                        AppConstants.privacyPolicyQ1,
                        style: TextStyle(
                            color: Color(0xff2A2C35),
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Text(
                        AppConstants.privacyPolicyA1,
                        style: TextStyle(
                            color: Color(0xff757885),
                            fontSize: 13,
                            wordSpacing: 1,
                            height: 1.5,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Text(
                        AppConstants.privacyPolicyQ2,
                        style: TextStyle(
                            color: Color(0xff2A2C35),
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Text(
                        AppConstants.privacyPolicyA2,
                        style: TextStyle(
                            color: Color(0xff757885),
                            wordSpacing: 1,
                            height: 1.5,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
