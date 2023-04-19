// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:signboard/modules/categoryscreen/primepopup/primepopup_view.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/utils/categorylist.dart';
import 'package:signboard/utils/image_path_constants.dart';
import 'package:signboard/widgets/commentextfield.dart';
import 'package:signboard/widgets/commonappbar.dart';

class CategoryScreenView extends StatefulWidget {
  const CategoryScreenView({super.key});

  @override
  State<CategoryScreenView> createState() => _CategoryScreenViewState();
}

class _CategoryScreenViewState extends State<CategoryScreenView> {
  TextEditingController searchController = TextEditingController();
  List cate = [];
  bool isShowPrime = false;
  List<String> selectedItems = [];
  bool isSelect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CommonAppbar(
            name: AppConstants.categoryText,
            centerTitleText: false,
            color: Colors.transparent,
            onClick: () {
              Navigator.pop(context, cate);
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 0),
                      child: Text(
                        AppConstants.categoryHeading,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff848CA1)),
                      ),
                    ),
                    SizedBox(height: 20),
                    CommonTextField(
                        controller: searchController,
                        hinttext: AppConstants.categorySearchHint,
                        padding: 0,
                        readonly: false,
                        textInputaction: TextInputAction.next,
                        fill: true,
                        fillColors: Colors.white,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                            ImagePath.searchIcon,
                            height: 22,
                          ),
                        ),
                        isObsecure: false),
                    SizedBox(height: 20),
                    GridView.builder(
                      itemCount: categoryList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: CheckboxListTile(
                            contentPadding: EdgeInsets.only(left: 10, right: 5),
                            checkboxShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            activeColor: Colors.green,
                            isThreeLine: false,
                            dense: true,
                            title: Text(
                              categoryList[index],
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: TextStyle(fontSize: 12),
                            ),
                            value: selectedItems.contains(categoryList[index]),
                            visualDensity: VisualDensity.standard,
                            onChanged: (bool? isChecked) {
                              setState(() {
                                if (isChecked == true) {
                                  setState(() {
                                    isSelect = true;
                                  });
                                  selectedItems.add(categoryList[index]);
                                } else {
                                  selectedItems.remove(categoryList[index]);
                                }
                              });
                            },
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 10.0,
                        mainAxisExtent: 55,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 0, right: 0, bottom: 10),
                      child: GestureDetector(
                        onTap: () {
                          if (selectedItems.length <= 1) {
                            Navigator.pop(context, selectedItems.join(' , '));
                          } else {
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    StatefulBuilder(
                                      builder: (BuildContext context,
                                          void Function(void Function())
                                              setState) {
                                        return PrimePopUpScreenView();
                                      },
                                    ));
                            log("multiple");
                          }
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
                                AppConstants.selectCategoryText,
                                style: const TextStyle(
                                    color: Color(0xffF6F7FB),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(width: 8),
                              isShowPrime == true
                                  ? Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Image.asset(ImagePath.primeTrans,
                                          height: 18, width: 18),
                                    )
                                  : Container(
                                      height: 18,
                                      width: 18,
                                      color: Colors.transparent,
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
