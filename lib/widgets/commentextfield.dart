// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signboard/utils/text_styles.dart';

class CommonTextField extends StatelessWidget {
  TextEditingController controller;
  String? label;
  String hinttext;
  double padding;
  TextInputType? textInputType;
  FormFieldValidator? validator;
  String? suffixtext;
  bool readonly = false;
  Color? fillColors;
  bool? fill;
  List<LengthLimitingTextInputFormatter>? textInputFormatter;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextInputAction textInputaction;
  bool isObsecure;
  CommonTextField(
      {Key? key,
      required this.controller,
      this.label,
      required this.hinttext,
      required this.padding,
      this.validator,
      this.suffixtext,
      this.fillColors,
      this.fill,
      required this.readonly,
      this.textInputType,
      this.textInputFormatter,
      required this.textInputaction,
      this.prefixIcon,
      this.suffixIcon,
      required this.isObsecure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: padding),
      child: Container(
        height: 55,
        decoration: BoxDecoration(border: Border.all(color: Color(0xffC5D0DE)), borderRadius: BorderRadius.circular(13),),
        child: TextFormField(
          inputFormatters: textInputFormatter,
          readOnly: readonly,
          obscureText: isObsecure,
          textInputAction: textInputaction,
          keyboardType: textInputType,
          controller: controller,
          validator: validator,
          onTap: () {},
          style: TextStyle(fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            fillColor: fillColors,
            filled: fill,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide.none
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none
            ),
            hintText: hinttext,
            suffixText: suffixtext,
            hintStyle: hintTextStyle,
          ),
        ),
      ),
    );
  }
}
