// ignore_for_file: prefer_const_constructors, unused_local_variable, deprecated_member_use, use_build_context_synchronously, must_be_immutable

import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signboard/Core/Constant/CommonUtils.dart';
import 'package:signboard/models/get_province_model.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/utils/image_path_constants.dart';
import 'package:signboard/widgets/commentextfield.dart';
import 'package:signboard/widgets/commonappbar.dart';

class ProvinceScreenView extends StatefulWidget {
  String? countryCode;
  ProvinceScreenView({super.key, this.countryCode});

  @override
  State<ProvinceScreenView> createState() => _ProvinceScreenViewState();
}

class _ProvinceScreenViewState extends State<ProvinceScreenView> {
  String? selectedCountryImage;
  String? selectedCountryName;
  GetProvinceModel? getProvinceModel;
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
            name: AppConstants.provinceHeading,
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
                        hinttext: AppConstants.searchProvinceHintText,
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
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          getProvinceModel != null && getProvinceModel != null
                              ? getProvinceModel!.data![0].states!.length
                              : 0,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                /* selectedCountryImage = getProvinceModel!
                                    .data![index].flag
                                    .toString(); */
                                // allCountriesList[index]["IMAGE"];
                                selectedCountryName = getProvinceModel!
                                    .data![index].states
                                    .toString();
                                // allCountriesList[index]["TEXT"];
                              });

                              Navigator.of(context).pop({
                                "image": selectedCountryImage,
                                "text": selectedCountryName
                              });
                              log(selectedCountryImage.toString());
                              log(selectedCountryName.toString());
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
                                  Container(
                                    width: 110,
                                    color: Colors.transparent,
                                    child: Text(
                                      getProvinceModel != null &&
                                              getProvinceModel!
                                                  .data![index].name!.isNotEmpty
                                          ? getProvinceModel!.data![index].name
                                              .toString()
                                          : allCountriesList[index]["TEXT"],
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: Color(0xff8186A1),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                    ),
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
      getProvinceAPI();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getProvinceAPI();
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

  getProvinceAPI() async {
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
      var response = await dio.get(
          "https://countriesnow.space/api/v0.1/countries/states",
          data: {"country": "${widget.countryCode}"});
      log("Country Respnse::::::${response.data}");
      if (response.statusCode == 200) {
        CommonUtils.hideProgressLoading(context);
        setState(() {
          getProvinceModel = GetProvinceModel.fromJson((response.data));
        });
      } else {
        CommonUtils.hideProgressLoading(context);
      }
    } on DioError catch (e) {
      log("Country error $e");
    }
  }
}

/*  */