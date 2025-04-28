import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DesignTwoTemplate extends StatelessWidget {
  const DesignTwoTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Preview Invoice 2",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
