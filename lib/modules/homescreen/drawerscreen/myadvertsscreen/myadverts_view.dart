// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signboard/modules/homescreen/drawerscreen/myadvertsscreen/createaddscreen/createad_view.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/utils/image_path_constants.dart';
import 'package:signboard/widgets/commonappbar.dart';

class MyAdvertScreenView extends StatefulWidget {
  const MyAdvertScreenView({super.key});

  @override
  State<MyAdvertScreenView> createState() => _MyAdvertScreenViewState();
}

class _MyAdvertScreenViewState extends State<MyAdvertScreenView> {
  List<bool> switchControl = [false];
  var textHolder = 'Switch is OFF';
  bool switchValue = true;
  List advertsIteamList = [
    AppConstants.indiaText,
    AppConstants.indiaText,
    AppConstants.indiaText,
    AppConstants.indiaText,
    AppConstants.indiaText,
    AppConstants.indiaText,
    AppConstants.indiaText,
    AppConstants.indiaText,
    AppConstants.indiaText,
    AppConstants.indiaText,
    AppConstants.indiaText,
  ];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < advertsIteamList.length; i++) {
      switchControl.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingButton(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonAppbar(
              name: AppConstants.myadverts,
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
                    children: [
                      SizedBox(height: 10),
                      Text(
                        AppConstants.advertsMove,
                        style: TextStyle(
                            color: Color(0xff848CA1),
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 20),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: advertsIteamList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = advertsIteamList[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              height: 97,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 0.2,
                                    blurRadius: 10,
                                    offset: Offset(4, 6),
                                    color: Color(0xff000000).withOpacity(.1),
                                  ),
                                ],
                                border: Border.all(
                                  color: Color(0xffD1D0D3).withOpacity(.5),
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 15),
                                  Container(
                                    height: 61,
                                    width: 61,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      boxShadow: [
                                        BoxShadow(
                                          spreadRadius: 0.2,
                                          blurRadius: 10,
                                          offset: Offset(6, 6),
                                          color: Color(0xff000000)
                                              .withOpacity(.1),
                                        ),
                                      ],
                                      shape: BoxShape.circle,
                                      color: index == 0 ||
                                              index == 2 ||
                                              index == 5
                                          ? Color(0xff22B14C).withOpacity(.1)
                                          : index == 3
                                              ? Color(0xffFD6452)
                                                  .withOpacity(.2)
                                              : Color(0xffA13FF5)
                                                  .withOpacity(.2),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                          index == 0 ||
                                                  index == 2 ||
                                                  index == 5
                                              ? ImagePath.greenAdverts
                                              : index == 3
                                                  ? ImagePath.redAdverts
                                                  : ImagePath.purplceImage,
                                          height: 29,
                                          width: 29),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppConstants.napkinsRed,
                                          style: TextStyle(
                                              color: Color(0xff43495E),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          AppConstants.play,
                                          style: TextStyle(
                                              color: Color(0xff8A8E9B),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: 27,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: index == 0 ||
                                                    index == 2 ||
                                                    index == 5
                                                ? Color(0xff22B14C)
                                                    .withOpacity(.2)
                                                : index == 3
                                                    ? Color(0xffFD6452)
                                                        .withOpacity(.2)
                                                    : Color(0xffFCAC11)
                                                        .withOpacity(.2),
                                            borderRadius:
                                                BorderRadius.circular(22),
                                          ),
                                          child: Center(
                                            child: Text(
                                              index == 0 ||
                                                      index == 2 ||
                                                      index == 5
                                                  ? AppConstants.approvedText
                                                  : index == 3
                                                      ? "Reject"
                                                      : "Pending",
                                              style: TextStyle(
                                                  color: index == 0 ||
                                                          index == 2 ||
                                                          index == 5
                                                      ? Color(0xff22B14C)
                                                      : index == 3
                                                          ? Colors.red
                                                          : Color(0xffFCAC11),
                                                  fontSize: 11,
                                                  fontWeight:
                                                      FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Switch(
                                          onChanged: (value) {
                                            if (switchControl[index] ==
                                                value) {
                                              setState(() {
                                                switchControl[index] = value;
                                                textHolder = 'Switch is ON';
                                              });
                                              log('Switch is ON');
                                            } else {
                                              setState(() {
                                                switchControl[index] = value;
                                                textHolder = 'Switch is OFF';
                                              });
                                              log('Switch is OFF');
                                            }
                                          },
                                          value: switchControl[index],
                                          activeColor: Colors.green,
                                          activeTrackColor: Color(0xff5C6271)
                                              .withOpacity(.2),
                                          inactiveThumbColor:
                                              Color(0xff909090),
                                          inactiveTrackColor:
                                              Color(0xff5C6271)
                                                  .withOpacity(.2),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                ],
                              ),
                            ),
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

  Widget floatingButton() {
    return FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () {
          Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => const CreateAdScreenView(),
          ));
        },
        child: Container(
          height: 75,
          width: 75,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Color(0xffA13FF5)),
          child: Center(
            child: Icon(
              Icons.add,
              size: 25,
            ),
          ),
        ));
  }
}
