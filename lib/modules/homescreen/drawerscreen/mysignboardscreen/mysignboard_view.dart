// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signboard/Core/Constant/CommonUtils.dart';
import 'package:signboard/Core/Constant/url_constant.dart';
import 'package:signboard/Core/Constant/value_constants.dart';
import 'package:signboard/models/get_signboard_model.dart';
import 'package:signboard/modules/homescreen/viewsignboard/viewsignboard_view.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/utils/image_path_constants.dart';
import 'package:signboard/widgets/commonappbar.dart';

class MySignBoardScreenView extends StatefulWidget {
  const MySignBoardScreenView({super.key});

  @override
  State<MySignBoardScreenView> createState() => _MySignBoardScreenViewState();
}

class _MySignBoardScreenViewState extends State<MySignBoardScreenView> {
  String? userToken;
  GetSignboardModel? getSignboardModel;
  List homeGridList = [
    ImagePath.home1Image,
    ImagePath.home2Image,
    ImagePath.home3Image,
    ImagePath.home4Image,
    ImagePath.home5Image,
    ImagePath.home6Image,
  ];

  getPrefData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userToken = pref.getString(USER_TOKEN);
    log("user Token ::::: $userToken");
  }

  @override
  void initState() {
    super.initState();
    checkConnection();
    getPrefData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CommonAppbar(
              name: AppConstants.mysignBoard,
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
                      GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: /* getSignboardModel != null &&
                                getSignboardModel!.data != null
                            ? getSignboardModel!.data!.length
                            : */ homeGridList.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              // log('signboard id :::::::: ${getSignboardModel!.data![index].signboardId.toString()}');
                              /* Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) => ViewSignBoardScrenView(
                                    image: getSignboardModel != null &&
                                            getSignboardModel!.data != null
                                        ? getSignboardModel!
                                            .data![index].signboardImageId
                                        : "",
                                    signboardId: getSignboardModel != null &&
                                            getSignboardModel!.data != null
                                        ? getSignboardModel!
                                            .data![index].signboardId
                                            .toString()
                                        : "",
                                  ),
                                ),
                              ); */
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(23),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(23),
                                  child: Image.asset(
                                      /* getSignboardModel != null &&
                                              getSignboardModel!.data != null &&
                                              getSignboardModel!.data![index]
                                                  .signboardImageId!.isNotEmpty
                                          ? getSignboardModel!
                                              .data![index].signboardImageId!
                                          : */ homeGridList[index],fit: BoxFit.fill,)

                                  /* getSignboardModel != null &&
                                          getSignboardModel!.data != null &&
                                          getSignboardModel!
                                              .data![index]
                                              .signboardImageId!
                                              .isNotEmpty /* &&
                                          getSignboardModel!.data![index]
                                                  .signboardImageId !=
                                              "http://signboard.trsm.in/signboardimages/" */
                                      ? Image.network(getSignboardModel!
                                          .data![index]
                                          .signboardImageId! /* .toString() */)
                                      : Image.network(
                                          "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png",
                                          height: 208,
                                          width: 166,
                                          fit: BoxFit.fill,
                                        ), */
                                  ),
                            ),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 17.0,
                          mainAxisSpacing: 17.0,
                          mainAxisExtent: 200,
                        ),
                      ),
                      /* GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: homeGridList.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              /* Navigator.of(context).push(
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              ViewSignBoardScrenView(
                                            image: homeGridList[index],
                                          ),
                                        ),
                                      ); */
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(23),
                              child: Image.asset(homeGridList[index],
                                  height: 208, width: 166,fit: BoxFit.fill,),
                            ),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 17.0,
                          mainAxisSpacing: 17.0,
                          mainAxisExtent: 200,
                        ),
                      ), */
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

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // getSignboardAPI();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // getSignboardAPI();
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Alert"),
              content: Text("Check Your Internet Connection"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok")),
              ],
            );
          });
    }
  }

  getSignboardAPI() async {
    CommonUtils.showProgressLoading(context);
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      var queryParameters = {
        "pageno": "1",
        "data_per_page": "10",
        "filters": "0",
      };
      var params = {"t": "$userToken"};
      String queryString = Uri(queryParameters: queryParameters).query;
      log("getSignboard queryParameters ::::::$queryParameters");
      log("getSignboard Params ::::::$params");
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
        dioClient.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      };
      var response = await dio.post("$GETSIGNBOARD_URl?$queryString",
          data: jsonEncode(params));
      log("getSignboard Respnse::::::${response.data}");
      if (response.statusCode == 200) {
        CommonUtils.hideProgressLoading(context);
        setState(() {
          getSignboardModel = GetSignboardModel.fromJson(response.data);
        });
      } else {}
    } on DioError catch (e) {
      log("getSignboard error $e");
    }
  }
}
