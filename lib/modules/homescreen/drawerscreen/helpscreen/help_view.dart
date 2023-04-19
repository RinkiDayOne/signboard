import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:signboard/utils/app_constants.dart';
import 'package:signboard/widgets/commonappbar.dart';

class HelpScreenView extends StatefulWidget {
  const HelpScreenView({super.key});

  @override
  State<HelpScreenView> createState() => _HelpScreenViewState();
}

class _HelpScreenViewState extends State<HelpScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
        child: Column(
          children: [
            CommonAppbar(
            name: AppConstants.help,
            centerTitleText: false,
            color: Colors.transparent,
            onClick: () {
              Navigator.pop(context);
            },
          ),
            Column(),
          ],
        ),
      ),);
  }
}