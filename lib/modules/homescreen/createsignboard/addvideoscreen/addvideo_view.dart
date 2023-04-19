// ignore_for_file: prefer_const_constructors, deprecated_member_use

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
import 'package:video_player/video_player.dart';

class AddVideoScreenView extends StatefulWidget {
  const AddVideoScreenView({super.key});

  @override
  State<AddVideoScreenView> createState() => _AddVideoScreenViewState();
}

class _AddVideoScreenViewState extends State<AddVideoScreenView> {
  File? _video;
  final picker = ImagePicker();
  VideoPlayerController? videoPlayerController;
  UploadProductImageModel? uploadProductImageModel;

  @override
  void initState() {
    super.initState();
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
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            CommonAppbar(
              name: AppConstants.addVideo,
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
                    (videoPlayerController != null)
                        ? Column(
                            children: [
                              AspectRatio(
                                aspectRatio:
                                    videoPlayerController!.value.aspectRatio,
                                child: VideoPlayer(videoPlayerController!),
                              ),
                              VideoProgressIndicator(
                                videoPlayerController!,
                                allowScrubbing: true,
                                colors: VideoProgressColors(
                                    backgroundColor: Colors.red,
                                    bufferedColor: Colors.black,
                                    playedColor: Colors.blueAccent),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CupertinoButton(
                                    child: Icon(Icons.pause),
                                    onPressed: () {
                                      setState(() {
                                        videoPlayerController!.pause();
                                      });
                                    },
                                  ),
                                  CupertinoButton(
                                    child: Icon(Icons.play_arrow),
                                    onPressed: () {
                                      setState(() {
                                        videoPlayerController!.play();
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
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
                    SizedBox(height: 15),
                    Text(
                      AppConstants.addYourVideo,
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
                            // getFromCamera();
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
                            pickVideo();
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
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 0, right: 0, bottom: 10),
                      child: GestureDetector(
                        onTap: () {
                          uploadProductimageAPI(PickedFile(_video!.path));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 54,
                          decoration: BoxDecoration(
                            color: const Color(0xffA13FF5),
                            borderRadius: BorderRadius.circular(9),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 0,
                                blurRadius: 24,
                                offset: const Offset(0, 14),
                                color: const Color(0xffA13FF5).withOpacity(.3),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppConstants.addVideo,
                                style: const TextStyle(
                                    color: Color(0xffF6F7FB),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(width: 8),
                              /* isShowPrime == true
                                  ? */
                              Padding(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: Image.asset(ImagePath.primeTrans,
                                    height: 18, width: 18),
                              )
                              /* : Container(
                                      height: 18,
                                      width: 18,
                                      color: Colors.transparent,
                                    ), */
                            ],
                          ),
                        ),
                      ),
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

  pickVideo() async {
    PickedFile? pickedFile = await picker.getVideo(source: ImageSource.gallery);
    _video = File(pickedFile!.path);
    videoPlayerController = VideoPlayerController.file(_video!)
      ..initialize().then((_) {
        setState(() {});
        videoPlayerController!.play();
      });
  }

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
              fromValue: "VIDEO",
              videoPlayerController: videoPlayerController,
              productVideoId: uploadProductImageModel != null &&
                      uploadProductImageModel!.data!.fileId!.isNotEmpty
                  ? uploadProductImageModel!.data!.fileId
                  : "",
            ),
          ),
        );
        log("product Video Id ::::: ${uploadProductImageModel!.data!.fileId.toString()}");
      } else {
        CommonUtils.hideProgressLoading(context);
      }
    } on DioError catch (e) {
      log("UploadImage error $e");
    }
  }
}
