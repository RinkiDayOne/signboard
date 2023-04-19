import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:signboard/utils/image_path_constants.dart';
import 'package:story_view/story_view.dart';

class StoryViewScreen extends StatefulWidget {
  String? image;
  StoryViewScreen({super.key, this.image});

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  final controller = StoryController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: NetworkImage(
            widget.image.toString(),
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 16, top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: Image.asset(
                    ImagePath.cancleImage,
                    height: 22,
                    width: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
