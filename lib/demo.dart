import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  bool isSelect = false;
  int? selectedIndex;

  List demo = [
    "a",
    "a",
    "a",
    "a",
    "a",
  ];

  isSelectedItem(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 500,
            color: Colors.red,
            child: ListView.builder(
              itemCount: demo.length,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    isSelectedItem(index);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 30,
                      width: 30,
                      color:
                          selectedIndex == index ? Colors.blue : Colors.yellow,
                      child: Center(child: Text(demo[index])),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
