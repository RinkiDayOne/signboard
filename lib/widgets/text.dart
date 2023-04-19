// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  String text;
  TextStyle? style;
  CommonText({super.key, required this.text, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xff8186A1).withOpacity(.7)),
    );
  }
}
