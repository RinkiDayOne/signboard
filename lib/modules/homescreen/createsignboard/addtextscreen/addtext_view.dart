// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unnecessary_null_comparison, deprecated_member_use

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:signboard/Core/Constant/CommonUtils.dart';
import 'package:signboard/Core/Constant/url_constant.dart';
import 'package:signboard/models/uploadproductimage_model.dart';
import 'package:signboard/modules/uploadsignboardscreen/uploadsignboard_view.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/utils/image_path_constants.dart';
import 'package:signboard/widgets/commonappbar.dart';
import 'package:signboard/widgets/submit_button.dart';
import 'package:signboard/widgets/text.dart';
import 'package:text_editor/text_editor.dart';
import 'dart:ui' as ui;

class AddTextScreenView extends StatefulWidget {
  const AddTextScreenView({super.key});

  @override
  State<AddTextScreenView> createState() => _AddTextScreenViewState();
}

class _AddTextScreenViewState extends State<AddTextScreenView> {
  GlobalKey previewContainer = GlobalKey();
  ScreenshotController screenshotController = ScreenshotController();
  double top = 0;
  double left = 0;
  double bottom = 0;
  double right = 0;
  double textSize = 30;
  String _text = 'Demo text';
  final fonts = ['Arial', 'Helvetica', 'Verdana'];
  List<Color> colorList = [
    Colors.black,
    Colors.red,
    Colors.black,
    Colors.yellow,
    Colors.blue,
    Colors.green,
    Colors.grey,
  ];
  TextStyle _textStyle = const TextStyle(
    fontSize: 30,
    color: Colors.white,
  );
  File? imagePath;
  UploadProductImageModel? uploadProductImageModel;
  Color bgColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            CommonAppbar(
              name: AppConstants.addText,
              centerTitleText: false,
              color: Colors.transparent,
              onClick: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16, left: 0, right: 0, bottom: 0),
                      child: Screenshot(
                        controller: screenshotController,
                        child: Container(
                          height: 400,
                          decoration: BoxDecoration(
                            color: bgColor,
                            /* gradient: LinearGradient(
                              colors: [
                                Color(0xffD39465),
                                Color(0xffF1BA8F),
                              ],
                              stops: [0.0, 1.0],
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                            ), */
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: top,
                                left: left,
                                bottom: bottom,
                                right: right,
                                child: GestureDetector(
                                  onPanUpdate: (details) {
                                    setState(() {
                                      left += details.delta.dx;
                                      top += details.delta.dy;
                      
                                      // Make sure the text stays within the container
                                      if (left < 0) left = 0;
                                      if (top < 0) top = 0;
                                      if (right < 0) right = 0;
                                      if (bottom < 0) bottom = 0;
                                      if (left > 400 - textSize) {
                                        left = 400 - textSize;
                                      }
                                      if (top > 400 - textSize) {
                                        top = 400 - textSize;
                                      }
                                      if (right > 400 - textSize) {
                                        right = 400 - textSize;
                                      }
                                      if (bottom > 400 - textSize) {
                                        bottom = 400 - textSize;
                                      }
                                    });
                                  },
                                  child: Transform.scale(
                                    scale: 1.0,
                                    child: GestureDetector(
                                      onTap: () =>
                                          _tapHandler(_text, _textStyle),
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Text(
                                          _text,
                                          style: _textStyle,
                                          // textAlign: _textAlign,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    CommonText(text: AppConstants.changeBgColor),
                    SizedBox(height: 15),
                    Container(
                      height: 35,
                      child: ListView.builder(
                        itemCount: colorList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  bgColor = colorList[index];
                                });
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: colorList[index],
                                    shape: BoxShape.circle),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    CommonButton(
                      btnName: AppConstants.applyText,
                      btnOnTap: () {
                        captureSocialPng();
                      },
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /* Future<void> captureSocialPng() {
    List<String> imagePaths = [];
    final RenderBox box = context.findRenderObject() as RenderBox;
    return Future.delayed(const Duration(milliseconds: 20), () async {
      RenderRepaintBoundary? boundary = previewContainer.currentContext!
          .findRenderObject() as RenderRepaintBoundary?;

      ui.Image image = await boundary!.toImage();
      final directory = (await getApplicationDocumentsDirectory()).path;
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      File imgFile = File('$directory/screenshot.jpg');
      imagePaths.add(imgFile.path);
      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (context) => UploadSignboardScreenView(
            fromValue: "TEXT",
            createPost: imgFile,
          ),
        ),
      );
      /* imgFile.writeAsBytes(pngBytes).then((value) async {
        await Share.shareFiles(imagePaths,
            subject: 'Share',
            text: 'Congratulation',
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
      }).catchError((onError) {
        print(onError);
      }); */
    });
  } */

  captureSocialPng() async {
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/image.png').create();
        await imagePath.writeAsBytes(image);
        log("imagePath :::::: ${imagePath.path}");
        uploadProductimageAPI(PickedFile(imagePath.path));
        log("File Id ::::::${uploadProductImageModel!.data!.fileId.toString()}");
        /*  if (imagePath != null) { */
        // uploadProductimageAPI();
        Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => UploadSignboardScreenView(
                  
                  fromValue: "TEXT",
                  productTextId: uploadProductImageModel != null &&
                          uploadProductImageModel!.data!.fileId!.isNotEmpty
                      ? uploadProductImageModel!.data!.fileId.toString()
                      : "",
                  pickTextImage: imagePath.path),
            ),
          );
        /*  } */
      }
    });
  }

  void _tapHandler(text, textStyle) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(
        milliseconds: 200,
      ),
      pageBuilder: (_, __, ___) {
        return Container(
          height: 400,
          color: Colors.black.withOpacity(0.4),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: TextEditor(
                fonts: fonts,
                text: text,
                textStyle: _textStyle,
                minFontSize: 30,
                onEditCompleted: (style, align, text) {
                  setState(() {
                    _text = text;
                    _textStyle = style;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  /* uploadProductimageAPI(PickedFile selectedImage) async {
    Dio dio = Dio();
    CommonUtils.showProgressLoading(context);
    try {
      FormData formData = FormData.fromMap(
        {
          "sendimage": selectedImage != null
              ? await MultipartFile.fromFile(selectedImage.path,
                  filename: selectedImage.path.split('/').last)
              : null,
        },
      );
      log("UploadImage Params ::::::$formData");
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
        dioClient.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      };
      var response = await dio.post(UPLOADPRODUCT_IMAGE_URl, data: (formData));
      log("UploadImage Respnse::::::${response.data}");
      if (response.statusCode == 200) {
        CommonUtils.hideProgressLoading(context);
        setState(() {
          uploadProductImageModel =
              UploadProductImageModel.fromJson(response.data);
        });

        log("product Image Id ::::: ${uploadProductImageModel!.data!.fileId.toString()}");
        CommonUtils.hideProgressLoading(context);
      } else {
        CommonUtils.hideProgressLoading(context);
      }
    } on DioError catch (e) {
      log("UploadImage error $e");
    }
  } */

  uploadProductimageAPI(PickedFile selectedImage) async {
    Dio dio = Dio();
    // CommonUtils.showProgressLoading(context);
    try {
      FormData formData = FormData.fromMap(
        {
          "sendimage": selectedImage != null
              ? await MultipartFile.fromFile(selectedImage.path,
                  filename: selectedImage.path.split('/').last)
              : null,
        },
      );
      log("UploadImage Params ::::::$formData");
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
        dioClient.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      };
      var response = await dio.post(UPLOADPRODUCT_IMAGE_URl, data: (formData));
      log("UploadImage Respnse::::::${response.data}");
      if (response.statusCode == 200) {
        // CommonUtils.hideProgressLoading(context);
        setState(() {
          uploadProductImageModel =
              UploadProductImageModel.fromJson((response.data));
        });
        log("File Id ::::::${uploadProductImageModel!.data!.fileId.toString()}");
        // log("product Image Id ::::: ${uploadProductImageModel!.data!.productImage.toString()}");

        /* Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => UploadSignboardScreenView(
                fromValue: "TEXT", pickTextImage: imagePath!.path),
          ),
        ); */
      } else {
        CommonUtils.hideProgressLoading(context);
      }
    } on DioError catch (e) {
      log("UploadImage error $e");
    }
  }
}
