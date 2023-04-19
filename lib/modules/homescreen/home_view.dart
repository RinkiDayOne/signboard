// ignore_for_file: prefer_const_constructors, unused_local_variable, use_build_context_synchronously, deprecated_member_use

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signboard/Core/Constant/CommonUtils.dart';
import 'package:signboard/Core/Constant/url_constant.dart';
import 'package:signboard/Core/Constant/value_constants.dart';
import 'package:signboard/models/get_signboard_model.dart';
import 'package:signboard/models/get_userdetail_model.dart';
import 'package:signboard/modules/homescreen/createsignboard/createsignboard_view.dart';
import 'package:signboard/modules/homescreen/drawerscreen/helpscreen/help_view.dart';
import 'package:signboard/modules/homescreen/drawerscreen/logoutpopup/logout_view.dart';
import 'package:signboard/modules/homescreen/drawerscreen/myadvertsscreen/myadverts_view.dart';
import 'package:signboard/modules/homescreen/drawerscreen/mysignboardscreen/mysignboard_view.dart';
import 'package:signboard/modules/homescreen/drawerscreen/privacypolicyscreen/privacy_view.dart';
import 'package:signboard/modules/homescreen/drawerscreen/profilescreen/profile_view.dart';
import 'package:signboard/modules/homescreen/drawerscreen/termsscreen/terms_view.dart';
import 'package:signboard/modules/homescreen/filterbox/filterbox_view.dart';
import 'package:signboard/modules/homescreen/notification/notification_view.dart';
import 'package:signboard/modules/homescreen/viewsignboard/viewsignboard_view.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/utils/image_path_constants.dart';
import 'package:signboard/utils/text_styles.dart';
import 'package:signboard/widgets/commentextfield.dart';
import 'package:video_player/video_player.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  String? version;
  String? appName;
  int selectedIndex = 0;
  GetUserDetailModel? getUserDetailModel;
  GetSignboardModel? getSignboardModel;
  String? userToken;
  TextEditingController searchController = TextEditingController();
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  VideoPlayerController? videoPlayerController;

  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  List categoryList = [
    AppConstants.allText,
    AppConstants.nearYouText,
    AppConstants.popular,
    AppConstants.newestText,
  ];

  List homeGridList = [
    ImagePath.home1Image,
    ImagePath.home2Image,
    ImagePath.home3Image,
    ImagePath.home4Image,
    ImagePath.home5Image,
    ImagePath.home6Image,
  ];

  List<Map<String, dynamic>> drawerList = [
    {"IMAGE": ImagePath.profileImage, "TEXT": AppConstants.myProfile},
    {"IMAGE": ImagePath.mySignBoardImage, "TEXT": AppConstants.mySignboard},
    {"IMAGE": ImagePath.myAdvertsImage, "TEXT": AppConstants.myAdverts},
    {"IMAGE": ImagePath.helpImage, "TEXT": AppConstants.helpSupport},
    {"IMAGE": ImagePath.shareDImage, "TEXT": AppConstants.shareApp},
    {"IMAGE": ImagePath.privacyImage, "TEXT": AppConstants.privacy},
    {"IMAGE": ImagePath.termsImage, "TEXT": AppConstants.terms},
    {"IMAGE": ImagePath.logoutImage, "TEXT": AppConstants.logout},
  ];

  List drawerNavigate = [
    MyProfileScreenView(),
    MySignBoardScreenView(),
    MyAdvertScreenView(),
    HelpScreenView(),
    HelpScreenView(),
    PrivacyPolicyScreenView(),
    TermScreenView(),
  ];

  selectCategory(int index) {
    selectedIndex = index;
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = info;
      version = info.version;
      appName = info.appName;
    });
    log("Appversion:::::$version");
  }

  getPrefData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userToken = pref.getString(USER_TOKEN);
    log("user Token ::::: $userToken");
  }

  @override
  void initState() {
    super.initState();
    checkConnection();
    _initPackageInfo();
    getPrefData();
  }

  @override
  void dispose() {
    videoPlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: globalKey,
      drawer: drawerView(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            globalKey.currentState!.openDrawer();
                          },
                          child: Image.asset(
                            ImagePath.drawerImage,
                            height: 41,
                            width: 41,
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          CreateSignBoardScreenView()),
                                );
                              },
                              child: Image.asset(
                                ImagePath.plusImage,
                                height: 41,
                                width: 41,
                              ),
                            ),
                            SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          NotificationScreenView()),
                                );
                              },
                              child: Image.asset(
                                ImagePath.notificationRed,
                                height: 41,
                                width: 41,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppConstants.helloText,
                          style: regularHeadingStyle.copyWith(
                              fontSize: 23, fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          child: Text(
                            getUserDetailModel != null &&
                                    getUserDetailModel!.data != null &&
                                    getUserDetailModel!.data![0].fullname !=
                                        null
                                ? getUserDetailModel!.data![0].fullname!
                                    .toString()
                                : "",
                            // AppConstants.rebertJohnText,
                            style: regularHeadingStyle.copyWith(
                                // decoration: TextDecoration.underline,
                                fontSize: 23,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    CommonTextField(
                        controller: searchController,
                        hinttext: AppConstants.searchHint,
                        padding: 0,
                        readonly: false,
                        textInputaction: TextInputAction.done,
                        fill: true,
                        fillColors: Colors.white,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                            ImagePath.searchIcon,
                            height: 22,
                          ),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    StatefulBuilder(
                                      builder: (BuildContext context,
                                          void Function(void Function())
                                              setState) {
                                        return FilterScreenView();
                                      },
                                    ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset(
                              ImagePath.filterImage,
                              height: 22,
                            ),
                          ),
                        ),
                        isObsecure: false),
                    SizedBox(height: 25),
                    // list and grid
                    Column(
                      children: [
                        Container(
                          height: 48,
                          width: width,
                          color: Colors.transparent,
                          child: Center(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: categoryList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectCategory(index);
                                    });
                                    if (index == 1) {
                                      getSignboardAPI("1");
                                      log("category index 1  ::::: ");
                                    } else if (index == 2) {
                                      getSignboardAPI("2");
                                      log("category index 2 ::::: ");
                                    } else if (index == 3) {
                                      getSignboardAPI("3");
                                      log("category index 3 ::::: ");
                                    } else {
                                      getSignboardAPI("0");
                                      log("category index ::::: ");
                                    }
                                    log("category index ::::: ");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          categoryList[index],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: selectedIndex == index
                                                ? Color(0xffA13FF5)
                                                : Color(0xff5E6872),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        selectedIndex == index
                                            ? Image.asset(
                                                ImagePath.homeTabImage,
                                                height: 5,
                                                width: 26)
                                            : Container()
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: getSignboardModel != null &&
                                  getSignboardModel!.data != null
                              ? getSignboardModel!.data!.length
                              : 0,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                log('signboard id :::::::: ${getSignboardModel!.data![index].signboardId.toString()}');
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        ViewSignBoardScrenView(
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
                                      wpNumber: getSignboardModel != null &&
                                              getSignboardModel!.data != null
                                          ? getSignboardModel!
                                              .data![index].whatsapp
                                              .toString()
                                          : "",
                                      callNumber: getSignboardModel != null &&
                                              getSignboardModel!.data != null
                                          ? getSignboardModel!
                                              .data![index].callnumber
                                              .toString()
                                          : "",
                                      signboardEmail: getSignboardModel !=
                                                  null &&
                                              getSignboardModel!.data != null
                                          ? getSignboardModel!
                                              .data![index].email
                                              .toString()
                                          : "",
                                      signboardImageId: getSignboardModel !=
                                                  null &&
                                              getSignboardModel!.data != null
                                          ? getSignboardModel!
                                              .data![index].signboardImageId
                                              .toString()
                                          : "",
                                      signboardCountry: getSignboardModel !=
                                                  null &&
                                              getSignboardModel!.data != null
                                          ? getSignboardModel!
                                              .data![index].country
                                              .toString()
                                          : "",
                                      signboardCountryFlag: getSignboardModel !=
                                                  null &&
                                              getSignboardModel!.data != null
                                          ? getSignboardModel!.data![index].flag
                                              .toString()
                                          : "",
                                      signboardCategory: getSignboardModel !=
                                                  null &&
                                              getSignboardModel!.data != null
                                          ? getSignboardModel!
                                              .data![index].signboardCategory
                                              .toString()
                                          : "",
                                      createUrl: getSignboardModel !=
                                                  null &&
                                              getSignboardModel!.data != null
                                          ? getSignboardModel!
                                              .data![index].weburl
                                              .toString()
                                          : "",
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(23),
                                ),
                                child: getSignboardModel != null &&
                                        getSignboardModel!.data != null &&
                                        getSignboardModel!.data![index]
                                                .signboardCategory ==
                                            "VIDEO"
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(23),
                                        child: AspectRatio(
                                            aspectRatio: videoPlayerController!
                                                .value.aspectRatio,
                                            child: VideoPlayer(
                                                videoPlayerController!)),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(23),
                                        child: getSignboardModel != null &&
                                                getSignboardModel!.data !=
                                                    null &&
                                                getSignboardModel!
                                                    .data![index]
                                                    .signboardImageId!
                                                    .isNotEmpty
                                            ? Image(
                                                image: NetworkImage(
                                                  (getSignboardModel!
                                                      .data![index]
                                                      .signboardImageId!),
                                                ),
                                                fit: BoxFit.fill,
                                              )
                                            : Image(
                                                image: AssetImage(
                                                    ImagePath.noDataImage),
                                              )

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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 17.0,
                            mainAxisSpacing: 17.0,
                            mainAxisExtent: 200,
                          ),
                        ),
                        SizedBox(height: 10)
                      ],
                    ),
                    // no data portion
                    // noDataPortion()
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget noDataPortion() {
    return Column(
      children: [
        Center(child: Image.asset(ImagePath.noDataImage, height: 190)),
        SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Text(
            AppConstants.oopsText,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xff2C3E50),
                fontSize: 22,
                fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Text(
            AppConstants.itSoonText,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xff757885),
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }

  Widget drawerView() {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // padding: const EdgeInsets.all(0),
        children: [
          SizedBox(height: 35),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(ImagePath.backIcon,
                          height: 43, width: 43),
                    ),
                    SizedBox(width: 16),
                    Text(
                      AppConstants.myMenuText,
                      style: TextStyle(
                          color: Color(0xff2C3E50),
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: drawerList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      children: [
                        SizedBox(height: 25),
                        GestureDetector(
                          onTap: () {
                            index == 7
                                ? showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        StatefulBuilder(
                                          builder: (BuildContext context,
                                              void Function(void Function())
                                                  setState) {
                                            return LogoutView();
                                          },
                                        ))
                                : Navigator.of(context).push(
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            drawerNavigate[index]),
                                  );
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Image.asset(drawerList[index]["IMAGE"],
                                    height: 22, width: 22),
                                SizedBox(width: 18),
                                Text(
                                  drawerList[index]["TEXT"],
                                  style: TextStyle(
                                      color: index == 7
                                          ? Color(0xffEA4335)
                                          : Color(0xff646B7B),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 25),
          Text("${AppConstants.appVersionText} $version"),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      userdetailsAPI();
      getSignboardAPI("0");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      userdetailsAPI();
      getSignboardAPI("0");
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

  userdetailsAPI() async {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    CommonUtils.showProgressLoading(context);
    try {
      var params = {"t": "$userToken"};
      log("Userdetails Params ::::::$params");
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
        dioClient.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      };
      var response = await dio.post(GETUSERDATA_URl, data: jsonEncode(params));
      log("Userdetails Respnse::::::${response.data}");
      if (response.statusCode == 200) {
        CommonUtils.hideProgressLoading(context);
        setState(() {
          getUserDetailModel = GetUserDetailModel.fromJson(response.data);
        });
        log("User Name ::::: ${getUserDetailModel!.data![0].username.toString()}");
      } else {
        CommonUtils.hideProgressLoading(context);
      }
    } on DioError catch (e) {
      log("Userdetails error $e");
    }
  }

  getSignboardAPI(String? filterIndex) async {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      var queryParameters = {
        "pageno": "1",
        "data_per_page": "10",
        "filter": filterIndex,
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
        setState(() {
          getSignboardModel = GetSignboardModel.fromJson(response.data);
        });
      } else {}
    } on DioError catch (e) {
      log("getSignboard error $e");
    }
  }
}
