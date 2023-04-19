// ignore_for_file: prefer_const_constructors, unused_local_variable, deprecated_member_use, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signboard/Core/Constant/CommonUtils.dart';
import 'package:signboard/Core/Constant/url_constant.dart';
import 'package:signboard/models/get_country_model.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/utils/image_path_constants.dart';
import 'package:signboard/utils/text_styles.dart';
import 'package:signboard/widgets/commentextfield.dart';
import 'package:signboard/widgets/commonappbar.dart';

class CountryScreenView extends StatefulWidget {
  const CountryScreenView({super.key});

  @override
  State<CountryScreenView> createState() => _CountryScreenViewState();
}

class _CountryScreenViewState extends State<CountryScreenView> {
  String? selectedCountryImage;
  String? selectedCountryName;
  String? selectedCountryCode;
  GetCountryModel? getCountryModel;
  TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> popularCountriesList = [
    {
      "IMAGE": ImagePath.ukImage,
      "TEXT": AppConstants.ukText,
    },
    {
      "IMAGE": ImagePath.usImage,
      "TEXT": AppConstants.usText,
    },
    {
      "IMAGE": ImagePath.ghanaImage,
      "TEXT": AppConstants.ghanaText,
    },
    {
      "IMAGE": ImagePath.nageriaImage,
      "TEXT": AppConstants.nageriaText,
    },
  ];

  List<Map<String, dynamic>> allCountriesList = [
    {
      "IMAGE": ImagePath.indiaImage,
      "TEXT": AppConstants.indiaText,
    },
    {
      "IMAGE": ImagePath.southAfricaImage,
      "TEXT": AppConstants.southText,
    },
    {
      "IMAGE": ImagePath.englandImage,
      "TEXT": AppConstants.englandText,
    },
    {
      "IMAGE": ImagePath.finlandImage,
      "TEXT": AppConstants.finlandText,
    },
    {
      "IMAGE": ImagePath.bangladeshImage,
      "TEXT": AppConstants.bangladeshText,
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          CommonAppbar(
            name: AppConstants.countryHeading,
            centerTitleText: false,
            color: Colors.transparent,
            onClick: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    CommonTextField(
                        controller: searchController,
                        hinttext: AppConstants.searchHintText,
                        padding: 0,
                        readonly: false,
                        textInputaction: TextInputAction.next,
                        fill: true,
                        fillColors: Colors.white,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            ImagePath.searchIcon,
                            height: 22,
                          ),
                        ),
                        isObsecure: false),
                    SizedBox(height: 20),
                    Text(
                      AppConstants.popularText,
                      style: regularHeadingStyle,
                    ),
                    SizedBox(height: 10),
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: popularCountriesList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCountryImage =
                                  popularCountriesList[index]["IMAGE"];
                              selectedCountryName =
                                  popularCountriesList[index]["TEXT"];
                            });
                            Navigator.of(context).pop({
                              "image": selectedCountryImage,
                              "text": selectedCountryName,
                             
                            });
                            log(selectedCountryImage.toString());
                            log(selectedCountryName.toString());
                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              border: Border.all(
                                color: Color(0xffC5D0DE).withOpacity(.60),
                              ),
                            ), 
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                SvgPicture.asset(
                                  popularCountriesList[index]["IMAGE"],
                                  height: 32,
                                  width: 32,
                                ),
                                SizedBox(width: 11),
                                Expanded(
                                  child: Text(
                                    popularCountriesList[index]["TEXT"],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Color(0xff8186A1),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
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
                    SizedBox(height: 20),
                    Text(
                      AppConstants.allCountrieText,
                      style: regularHeadingStyle,
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: getCountryModel != null &&
                              getCountryModel!.data != null
                          ? getCountryModel!.data!.length
                          : 0,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCountryImage = getCountryModel!
                                    .data![index].flag
                                    .toString();
                                // allCountriesList[index]["IMAGE"];
                                selectedCountryName = getCountryModel!
                                    .data![index].name
                                    .toString();
                                    selectedCountryCode = getCountryModel!.data![index].iso2.toString();
                                // allCountriesList[index]["TEXT"];
                              });

                              Navigator.of(context).pop({
                                "image": selectedCountryImage,
                                "text": selectedCountryName,
                                "iso2": selectedCountryCode
                              });
                              log(selectedCountryImage.toString());
                              log(selectedCountryName.toString());
                              log(selectedCountryCode.toString());
                            },
                            child: Container(
                              height: 70,
                              width: width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(13),
                                border: Border.all(
                                  color: Color(0xffC5D0DE).withOpacity(.60),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 8),
                                  Row(
                                    children: [
                                      getCountryModel != null &&
                                              getCountryModel!
                                                  .data![index].flag!.isNotEmpty
                                          ? SvgPicture.network(
                                              getCountryModel!.data![index].flag
                                                  .toString(),
                                              height: 32,
                                              width: 32,
                                            )
                                          : Image.asset(
                                              allCountriesList[index]["IMAGE"],
                                              height: 32,
                                              width: 32,
                                            ),
                                      SizedBox(width: 8),
                                      Container(
                                        width: 110,
                                        color: Colors.transparent,
                                        child: Text(
                                          getCountryModel != null &&
                                                  getCountryModel!.data![index]
                                                      .name!.isNotEmpty
                                              ? getCountryModel!
                                                  .data![index].name
                                                  .toString()
                                              : allCountriesList[index]["TEXT"],
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: Color(0xff8186A1),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  Image.asset(
                                    ImagePath.rightIcon,
                                    height: 20,
                                    width: 20,
                                  ),
                                  SizedBox(width: 8),
                                ],
                              ),
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

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getCountryAPI();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getCountryAPI();
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

  getCountryAPI() async {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    CommonUtils.showProgressLoading(context);
    try {
      /* (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
        dioClient.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      }; */
      var response = await dio.get(COUNTRY_URl);
      log("Country Respnse::::::${response.data}");
      if (response.statusCode == 200) {
        setState(() {
          getCountryModel = GetCountryModel.fromJson(response.data);
        });
        CommonUtils.hideProgressLoading(context);
      } else {
        CommonUtils.hideProgressLoading(context);
      }
    } on DioError catch (e) {
      log("Country error $e");
    }
  }
}

class SelectItem {
  String? selectImage;
  String? selectName;

  SelectItem(this.selectImage, this.selectName);
}
