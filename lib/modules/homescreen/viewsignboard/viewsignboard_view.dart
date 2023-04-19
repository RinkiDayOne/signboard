// ignore_for_file: must_be_immutable, prefer_const_constructors, deprecated_member_use, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signboard/Core/Constant/url_constant.dart';
import 'package:signboard/Core/Constant/value_constants.dart';
import 'package:signboard/modules/homescreen/viewsignboard/storyscreen/story_view.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/utils/image_path_constants.dart';
import 'package:signboard/utils/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class ViewSignBoardScrenView extends StatefulWidget {
  String? image;
  String? signboardId;
  String? wpNumber;
  String? callNumber;
  String? signboardEmail;
  String? signboardImageId;
  String? signboardCountry;
  String? signboardCountryFlag;
  String? signboardCategory;
  String? createUrl;
  ViewSignBoardScrenView({
    super.key,
    this.image,
    this.signboardId,
    this.wpNumber,
    this.callNumber,
    this.signboardEmail,
    this.signboardImageId,
    this.signboardCountry,
    this.signboardCountryFlag,
    this.signboardCategory,
    this.createUrl,
  });

  @override
  State<ViewSignBoardScrenView> createState() => _ViewSignBoardScrenViewState();
}

class _ViewSignBoardScrenViewState extends State<ViewSignBoardScrenView> {
  bool isTapLike = false;
  String? userToken;
  List<Map<String, dynamic>> contactList = [
    {
      "TEXT": AppConstants.mailText,
      "IMAGE": ImagePath.mailImage,
    },
    {
      "TEXT": AppConstants.callUsText,
      "IMAGE": ImagePath.callUsImage,
    },
    {
      "TEXT": AppConstants.whatsAppText,
      "IMAGE": ImagePath.whatsAppImage,
    },
    {
      "TEXT": AppConstants.linkText,
      "IMAGE": ImagePath.linkImage,
    },
  ];
  List contactGreyImage = [
    ImagePath.mailGreyImage,
    ImagePath.callUsGreyImage,
    ImagePath.whatsAppGreyImage,
    ImagePath.linkGreyImage,
  ];
  GlobalKey previewContainer = GlobalKey();
  VideoPlayerController? videoPlayerController;
  bool isEmailCheck = false;
  bool isCallCheck = false;
  bool isWpCheck = false;
  bool isUrlCheck = false;

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
    if (widget.signboardCategory == "VIDEO") {
      videoPlayerController =
          VideoPlayerController.network(widget.signboardImageId.toString())
            ..addListener(() => setState(() {}))
            ..setLooping(true)
            ..initialize().then((value) => videoPlayerController!.play());
      /* videoPlayerController =
          VideoPlayerController.network(widget.signboardImageId.toString())
            ..initialize().then((value) {
              setState(() {});
            }); */
    } else {
      null;
    }
    log('wpNumber :::: ${widget.wpNumber}');
    log('callNumber :::: ${widget.callNumber}');
    log('signboardEmail :::: ${widget.signboardEmail}');
    log('createUrl :::: ${widget.createUrl}');
    if (widget.signboardEmail == "") {
      setState(() {
        isEmailCheck = true;
      });
      log('isEmailCheck :::: $isEmailCheck');
    }
    if (widget.callNumber == "") {
      setState(() {
        isCallCheck = true;
      });
      log('isCallCheck :::: $isCallCheck');
    }
    if (widget.wpNumber == "") {
      setState(() {
        isWpCheck = true;
      });
      log('isWpCheck :::: $isWpCheck');
    }
    if (widget.createUrl == "") {
      setState(() {
        isUrlCheck = true;
      });
      log('isUrlCheck :::: $isUrlCheck');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        ImagePath.backIcon,
                        height: 43,
                        width: 43,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      AppConstants.signboardText,
                      style: regularHeadingStyle,
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        captureSocialPng();
                      },
                      child: Image.asset(
                        ImagePath.shareImage,
                        height: 41,
                        width: 41,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        likeSignboardAPI();
                        setState(() {
                          isTapLike = !isTapLike;
                        });
                      },
                      child: isTapLike == true
                          ? Image.asset(
                              ImagePath.likeImage,
                              height: 46,
                              width: 46,
                            )
                          : Image.asset(
                              ImagePath.unlikeImage,
                              height: 46,
                              width: 46,
                            ),
                    ),
                    SizedBox(width: 10),
                    Image.asset(
                      ImagePath.flagImage,
                      height: 41,
                      width: 41,
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 8),
                            /* Image.network(
                              widget.signboardCountryFlag.toString(),
                              height: 22,
                              width: 22,
                            ), */
                            Image.asset(
                              ImagePath.indiaImage,
                              height: 22,
                              width: 22,
                            ),
                            SizedBox(width: 10),
                            Text(
                              widget.signboardCountry != ""
                                  ? widget.signboardCountry.toString()
                                  : AppConstants.indiaText,
                              style: TextStyle(
                                  color: Color(0xff61667C),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 8),
                            Image.asset(
                              ImagePath.provinceImage,
                              height: 22,
                              width: 22,
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
                      ],
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => StoryViewScreen(
                              image: widget.image,
                            ),
                          ),
                        );
                      },
                      child: RepaintBoundary(
                        key: previewContainer,
                        child: Container(
                          height: 394,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(23),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(23),
                              child: widget.signboardCategory == "VIDEO"
                                  ? AspectRatio(
                                      aspectRatio: videoPlayerController!
                                          .value.aspectRatio,
                                      child:
                                          VideoPlayer(videoPlayerController!),
                                    )
                                  : Image.network(widget.image.toString())),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: contactList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            if (index == 0 && isEmailCheck == false) {
                              setState(() {
                                sendingMails();
                              });
                              log("Mail NotEmpty");
                            }
                            if (index == 1 && isCallCheck == false) {
                              setState(() {
                                launchCaller();
                              });
                              log("Call NotEmpty");
                            }
                            if (index == 2 && isWpCheck == false) {
                              setState(() {
                                openWhatsApp();
                              });
                              log("WP NotEmpty");
                            }
                            if (index == 3 && isUrlCheck == false) {
                              openWebViewUrl();
                              log("Link NotEmpty");
                            }
                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: (index == 0 && isEmailCheck == true) ||
                                      (index == 1 && isCallCheck == true) ||
                                      (index == 2 && isWpCheck == true) ||
                                      (index == 3 && isUrlCheck == true)
                                  ? Colors.grey.withOpacity(0.3)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(13),
                              border: Border.all(
                                color: Color(0xffC5D0DE).withOpacity(.60),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 10),
                                Image.asset(
                                  (index == 0 && isEmailCheck == true) ||
                                          (index == 1 && isCallCheck == true) ||
                                          (index == 2 && isWpCheck == true) ||
                                          (index == 3 && isUrlCheck == true)
                                      ? contactGreyImage[index]
                                      : contactList[index]["IMAGE"],
                                  height: 32,
                                  width: 32,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  contactList[index]["TEXT"],
                                  style: TextStyle(
                                      color: Color(0xff494E5B),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 12.0,
                        mainAxisExtent: 65,
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  openWebViewUrl() async {
    var url = widget.createUrl.toString();
    log(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  openWhatsApp() async {
    var url = 'https://wa.me/%2B91${widget.wpNumber}?text=hello';
    log(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchCaller() async {
    var url = "tel:${widget.callNumber}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  sendingMails() async {
    var url = Uri.parse("mailto:${widget.signboardEmail}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> captureSocialPng() {
    List<String> imagePaths = [];
    final RenderBox box = context.findRenderObject() as RenderBox;
    // ignore: unnecessary_new
    return new Future.delayed(const Duration(milliseconds: 20), () async {
      RenderRepaintBoundary? boundary = previewContainer.currentContext!
          .findRenderObject() as RenderRepaintBoundary?;

      ui.Image image = await boundary!.toImage();
      final directory = (await getApplicationDocumentsDirectory()).path;
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      File imgFile = new File('$directory/screenshot.jpg');
      imagePaths.add(imgFile.path);
      imgFile.writeAsBytes(pngBytes).then((value) async {
        await Share.shareFiles(imagePaths,
            subject: 'Share',
            // text: 'Congratulation',
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
      }).catchError((onError) {
        print(onError);
      });
    });
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

  likeSignboardAPI() async {
    Dio dio = Dio();
    try {
      var params = {
        "t": "$userToken",
        "signboard_id": "${widget.signboardId}",
        "flag": "0",
      };
      log("likeSignboard Params ::::::$params");
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
        dioClient.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      };
      var response = await dio.put(LIKESINGBOARD_URl, data: jsonEncode(params));
      log("likeSignboard Respnse::::::${response.data}");
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: response.data["message"]);
        setState(() {
          // getSignboardModel = GetSignboardModel.fromJson(response.data);
        });
      } else {}
    } on DioError catch (e) {
      log("likeSignboard error $e");
    }
  }
}
