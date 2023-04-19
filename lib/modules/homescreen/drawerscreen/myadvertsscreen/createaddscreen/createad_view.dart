// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:signboard/modules/countryscreen/country_view.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/utils/image_path_constants.dart';
import 'package:signboard/utils/text_styles.dart';
import 'package:signboard/widgets/commentextfield.dart';
import 'package:signboard/widgets/commonappbar.dart';
import 'package:signboard/widgets/submit_button.dart';
import 'package:signboard/widgets/text.dart';

class CreateAdScreenView extends StatefulWidget {
  const CreateAdScreenView({super.key});

  @override
  State<CreateAdScreenView> createState() => _CreateAdScreenViewState();
}

class _CreateAdScreenViewState extends State<CreateAdScreenView> {
  String? selectedValue;
  var result;
  String? selectedImage;
  String? selectName;
  String? fileName;
  String? pdfPath;
  final List<String> genderItems = [
    'Male',
    'Female',
  ];
  TextEditingController adtitleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonAppbar(
              name: AppConstants.createAdText,
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
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          CommonText(text: AppConstants.attachText),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              // openFileExplorer();
                            },
                            child: Container(
                              height: 126,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xffC5D0DE).withOpacity(.8),
                                ),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Spacer(),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                    SizedBox(width: 30),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                    Spacer(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          CommonText(text: AppConstants.uploadMaxText),
                          SizedBox(height: 15),
                          CommonText(text: AppConstants.adTitleText),
                          SizedBox(height: 10),
                          CommonTextField(
                            controller: adtitleController,
                            hinttext: AppConstants.adTitleText,
                            padding: 0,
                            readonly: false,
                            textInputaction: TextInputAction.next,
                            isObsecure: false,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Image.asset(ImagePath.myAdvertsImage,
                                  height: 22, width: 22),
                            ),
                          ),
                          SizedBox(height: 10),
                          CommonText(text: AppConstants.periodTitleText),
                          SizedBox(height: 10),
                          Container(
                            height: 55,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffC5D0DE)),
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Image.asset(ImagePath.periodSelect,
                                      height: 22, width: 22),
                                ),
                                Expanded(
                                  child: DropdownButtonFormField2(
                                    decoration: InputDecoration(
                                      isDense: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none),
                                      contentPadding: EdgeInsets.zero,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none),
                                      /* prefixIcon: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 0, top: 16, bottom: 16),
                                        child: Image.asset(ImagePath.periodSelect,
                                            height: 22, width: 22),
                                      ), */
                                    ),
                                    isExpanded: true,
                                    hint: Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: Text(
                                        "Select Period Validity",
                                        style: hintTextStyle,
                                      ),
                                    ),
                                    items: genderItems
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select gender.';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      //Do something when changing the item if you want.
                                    },
                                    onSaved: (value) {
                                      selectedValue = value.toString();
                                    },
                                    buttonStyleData: const ButtonStyleData(
                                      height: 60,
                                      padding:
                                          EdgeInsets.only(left: 20, right: 10),
                                    ),
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black45,
                                      ),
                                      iconSize: 30,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          CommonText(text: AppConstants.amountTitleText),
                          SizedBox(height: 10),
                          CommonTextField(
                            controller: amountController,
                            hinttext: AppConstants.amountTitleText,
                            padding: 0,
                            readonly: false,
                            textInputaction: TextInputAction.next,
                            isObsecure: false,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Image.asset(ImagePath.amountSelect,
                                  height: 22, width: 22),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                width: 55,
                                color: Colors.transparent,
                                child: Center(
                                  child: Text(
                                    AppConstants.inrText,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Color(0xff8186A1).withOpacity(.7)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          CommonText(text: AppConstants.reachTitleText),
                          SizedBox(height: 10),
                          Container(
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              border: Border.all(
                                color: Color(0xffC5D0DE).withOpacity(.8),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: 8),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Image.asset(
                                          /* selectedImage != null
                                                ? selectedImage.toString()
                                                : */
                                          ImagePath.reachSelect,
                                          height: 22,
                                          width: 22),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      /* selectName != null
                                          ? selectName.toString()
                                          : */
                                      AppConstants.reachTitleText,
                                      style: hintTextStyle,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Image.asset(
                                  ImagePath.rightIcon,
                                  height: 22,
                                  width: 22,
                                ),
                                SizedBox(width: 8),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          CommonText(text: AppConstants.countryHeading),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () async {
                              result = await Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      const CountryScreenView(),
                                ),
                              );
                              log("result : ${result['image']}");
                              if (result != null) {
                                setState(() {
                                  selectedImage = result['image'];
                                  selectName = result['text'];
                                });
                              }
                              log("select Image  $selectedImage");
                              log("select Name  $selectName");
                            },
                            child: Container(
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                border: Border.all(
                                  color: Color(0xffC5D0DE).withOpacity(.8),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 8),
                                  Row(
                                    children: [
                                      Image.asset(
                                          selectedImage != null
                                              ? selectedImage.toString()
                                              : ImagePath.indiaImage,
                                          height: 22,
                                          width: 22),
                                      SizedBox(width: 8),
                                      Text(selectName != null
                                          ? selectName.toString()
                                          : AppConstants.indiaText),
                                    ],
                                  ),
                                  Spacer(),
                                  Image.asset(
                                    ImagePath.rightIcon,
                                    height: 22,
                                    width: 22,
                                  ),
                                  SizedBox(width: 8),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          CommonText(text: AppConstants.linkText),
                          SizedBox(height: 10),
                          CommonTextField(
                            controller: linkController,
                            hinttext: AppConstants.linkText,
                            padding: 0,
                            readonly: false,
                            textInputaction: TextInputAction.next,
                            isObsecure: false,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Image.asset(ImagePath.linkImage,
                                  height: 22, width: 22),
                            ),
                          ),
                          SizedBox(height: 20),
                          CommonButton(
                              btnName: AppConstants.submitText,
                              btnOnTap: () {}),
                          SizedBox(height: 20),
                        ],
                      ),
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

  openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['mp4']);
    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        fileName = file.name;
        pdfPath = file.path;
        log("doc ::::::::::::::::::::::::$fileName");
        log("Pdf =>>>>>>>>>>>>>>>>>>>$pdfPath");
      });
    } else {}
  }
}
