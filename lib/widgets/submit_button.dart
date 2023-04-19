// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  String btnName;
  VoidCallback btnOnTap;
  CommonButton({Key? key, required this.btnName, required this.btnOnTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: btnOnTap,
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
        child: Text(
          btnName,
          style: const TextStyle(
              color: Color(0xffF6F7FB),
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
