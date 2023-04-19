// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:signboard/utils/image_path_constants.dart';
import 'package:signboard/utils/text_styles.dart';

class CommonAppbar extends StatelessWidget {
  String name;
  bool centerTitleText;
  VoidCallback? onClick;
  Color? color;
  CommonAppbar({Key? key, required this.name, required this.centerTitleText,this.onClick,this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color,
      elevation: 0,
      leadingWidth: 40,
      centerTitle: centerTitleText,
      leading: GestureDetector(
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Image.asset(ImagePath.backIcon,height: 43,width: 43,),
        ),
      ),
      title: Text(name, style: appBarHeading),
    );
  }
}
