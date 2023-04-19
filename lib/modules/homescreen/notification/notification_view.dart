// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/utils/image_path_constants.dart';
import 'package:signboard/widgets/commonappbar.dart';

class NotificationScreenView extends StatefulWidget {
  const NotificationScreenView({super.key});

  @override
  State<NotificationScreenView> createState() => _NotificationScreenViewState();
}

class _NotificationScreenViewState extends State<NotificationScreenView> {
  List<Map<String, dynamic>> notificationList = [
    {
      "IMAGE": ImagePath.notifi1,
      "TEXT": AppConstants.newPost,
      "DATE": AppConstants.date,
      "DETAIL": AppConstants.notifiDetail1,
    },
    {
      "IMAGE": ImagePath.notifi2,
      "TEXT": AppConstants.youHave,
      "DATE": AppConstants.date,
      "DETAIL": AppConstants.notifiDetail2,
    },
    {
      "IMAGE": ImagePath.notifi3,
      "TEXT": AppConstants.newPostIn,
      "DATE": AppConstants.date,
      "DETAIL": AppConstants.notifiDetail1,
    },
    {
      "IMAGE": ImagePath.notifi4,
      "TEXT": AppConstants.creditCard,
      "DATE": AppConstants.date,
      "DETAIL": AppConstants.notifiDetail2,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CommonAppbar(
            name: AppConstants.notifications,
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
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: notificationList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Container(
                            // height: 159,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                    color: Color(0xffD1D0D3).withOpacity(.7))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 15),
                                    Container(
                                      height: 61,
                                      width: 61,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          notificationList[index]["IMAGE"],
                                          height: 30,
                                          width: 30,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            notificationList[index]["TEXT"],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Color(0xff43495E),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            notificationList[index]["DATE"],
                                            style: TextStyle(
                                                color: Color(0xff43495E),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    index == 0 || index == 1
                                        ? Container(
                                            height: 27,
                                            width: 55,
                                            decoration: BoxDecoration(
                                              color: Color(0xffA13FF5),
                                              borderRadius:
                                                  BorderRadius.circular(22),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "New",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    SizedBox(width: 10),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Padding(
                                   padding: const EdgeInsets.only(left: 15,right: 15),
                                  child: Text(
                                    notificationList[index]["DETAIL"],
                                    style: TextStyle(
                                        color: Color(0xff565B69),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(height: 15),
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
    );
  }
}
