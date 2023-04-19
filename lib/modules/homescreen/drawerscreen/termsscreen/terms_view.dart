// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/widgets/commonappbar.dart';

class TermScreenView extends StatefulWidget {
  const TermScreenView({super.key});

  @override
  State<TermScreenView> createState() => _TermScreenViewState();
}

class _TermScreenViewState extends State<TermScreenView> {
  List<Map<String, dynamic>> termsList = [
    {
      "HEAD": AppConstants.terms,
      "TEXT": AppConstants.termsPar1,
    },
    {
      "HEAD": AppConstants.termsHead1,
      "TEXT": AppConstants.termsPar2,
    },
    {
      "HEAD": AppConstants.termsHead2,
      "TEXT": AppConstants.termsPar3,
    },
    {
      "HEAD": AppConstants.termsHead3,
      "TEXT": AppConstants.termsPar4,
    },
    {
      "HEAD": AppConstants.termsHead4,
      "TEXT": AppConstants.termsPar5,
    },
    {
      "HEAD": AppConstants.termsHead5,
      "TEXT": AppConstants.termsPar6,
    },
    {
      "HEAD": AppConstants.termsHead6,
      "TEXT": AppConstants.termsPar7,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CommonAppbar(
              name: AppConstants.terms,
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
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: termsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              index == 0
                                  ? SizedBox(height: 10)
                                  : SizedBox(height: 25),
                              Text(
                                termsList[index]["HEAD"],
                                style: TextStyle(
                                    color: Color(0xff333F52),
                                    fontSize: index == 0 ? 17 : 13,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10),
                              Text(
                                termsList[index]["TEXT"],
                                style: TextStyle(
                                    color: Color(0xff757885),
                                    wordSpacing: 1,
                                    height: 1.5,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10),
                            ],
                          );
                        },
                      )
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
