// ignore_for_file: prefer_const_constructors, deprecated_member_use, unnecessary_null_comparison

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signboard/Core/Constant/CommonUtils.dart';
import 'package:signboard/Core/Constant/url_constant.dart';
import 'package:signboard/models/uploadproductimage_model.dart';
import 'package:signboard/modules/uploadsignboardscreen/uploadsignboard_view.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/utils/image_path_constants.dart';
import 'package:signboard/utils/text_styles.dart';
import 'package:signboard/widgets/commonappbar.dart';
import 'package:signboard/widgets/submit_button.dart';

class AddImageScreenView extends StatefulWidget {
  const AddImageScreenView({super.key});

  @override
  State<AddImageScreenView> createState() => _AddImageScreenViewState();
}

class _AddImageScreenViewState extends State<AddImageScreenView> {
  final ImagePicker picker = ImagePicker();
  File? imageFile;
  UploadProductImageModel? uploadProductImageModel;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            CommonAppbar(
              name: AppConstants.addImage,
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
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: Container(
                        height: 400,
                        decoration: const BoxDecoration(
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
                        child: imageFile != null
                            ? ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                child: Image.file(
                                  File(imageFile!.path),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(
                                height: 394,
                                width: width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xffE3E6E9),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    AppConstants.signboardPreview,
                                    style: TextStyle(
                                        fontSize: 27,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xffE0E2E5)),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      AppConstants.addYourPhoto,
                      style: regularHeadingStyle,
                    ),
                    SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            getFromCamera();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(ImagePath.cameraSelect,
                                  height: 65, width: 65),
                              SizedBox(height: 8),
                              Text(
                                AppConstants.cameraText,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff676C77)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 30),
                        GestureDetector(
                          onTap: () {
                            getFromGallery();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(ImagePath.gallerySelect,
                                  height: 65, width: 65),
                              SizedBox(height: 8),
                              Text(
                                AppConstants.galleryText,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff676C77)),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(height: 30),
                    CommonButton(
                      btnName: AppConstants.applyImage,
                      btnOnTap: () {
                        log("selected image ::::: ${imageFile}");
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => UploadSignboardScreenView(
                              fromValue: "IMAGE",
                              selectedImage: imageFile,
                              productImageId: uploadProductImageModel != null &&
                                      uploadProductImageModel!
                                          .data!.fileId!.isNotEmpty
                                  ? uploadProductImageModel!.data!.fileId
                                  : "",
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      uploadProductimageAPI(PickedFile(imageFile!.path));
    }
  }

  getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      uploadProductimageAPI(PickedFile(imageFile!.path));
    }
  }

  uploadProductimageAPI(PickedFile selectedImage) async {
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
  }
}
