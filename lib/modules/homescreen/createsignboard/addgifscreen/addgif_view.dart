// ignore_for_file: prefer_const_constructors, deprecated_member_use, unnecessary_null_comparison, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
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

class AddGifScreenView extends StatefulWidget {
  const AddGifScreenView({super.key});

  @override
  State<AddGifScreenView> createState() => _AddGifScreenViewState();
}

class _AddGifScreenViewState extends State<AddGifScreenView>
    with TickerProviderStateMixin {
  final ImagePicker picker = ImagePicker();
  File? imageFile;
  UploadProductImageModel? uploadProductImageModel;
  FlutterGifController? gifController;

  @override
  void initState() {
    gifController = FlutterGifController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      gifController!.repeat(
        min: 0,
        max: 13,
        period: const Duration(milliseconds: 200),
      );
    });
    super.initState();
  }

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
              name: AppConstants.addGif,
              centerTitleText: false,
              color: Colors.transparent,
              onClick: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                child: /* GifImage(
                                  controller: gifController!,
                                  image: const NetworkImage(
                                      "http://img.mp.itc.cn/upload/20161107/5cad975eee9e4b45ae9d3c1238ccf91e.jpg"),
                                ), */
                                    /* GifImage(
                                    image: AssetImage(
                                      (imageFile!.path),
                                    ),
                                    controller: gifController!) */
                                    Image.file(
                                  File(imageFile!.path),
                                  fit: BoxFit.fill,
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
                      AppConstants.addYourGif,
                      style: regularHeadingStyle,
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        getFromGallery();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                    SizedBox(height: 30),
                    CommonButton(
                      btnName: AppConstants.applyImage,
                      btnOnTap: () {
                        uploadProductimageAPI(PickedFile(imageFile!.path));
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
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['gif'],
    );
    if (result != null) {
      PlatformFile selectedFile = result.files.first;
      setState(() {
        imageFile = File(selectedFile.path!);
      });
    }
  }

  /* getFromGallery() async {
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
  } */

/*   getFromCamera() async {
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
  } */

  uploadProductimageAPI(PickedFile selectedImage) async {
    Dio dio = Dio();
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
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => UploadSignboardScreenView(
              fromValue: "GIF",
              selectedImage: imageFile,
              productGifId: uploadProductImageModel != null &&
                      uploadProductImageModel!.data!.fileId!.isNotEmpty
                  ? uploadProductImageModel!.data!.fileId.toString()
                  : "",
            ),
          ),
        );
        log("product Gif Id ::::: ${uploadProductImageModel!.data!.fileId.toString()}");
      } else {
        CommonUtils.hideProgressLoading(context);
      }
    } on DioError catch (e) {
      log("UploadImage error $e");
    }
  }
}
