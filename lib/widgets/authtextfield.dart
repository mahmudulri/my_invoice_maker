import 'package:flutter/material.dart';

class Authtextfield extends StatelessWidget {
  Authtextfield({
    required this.hinttext,
    this.controller,
    super.key,
  });

  String hinttext;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.065,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
          color: Colors.grey.shade300,
        ),
        color: Color(0xffF9FAFB),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: TextField(
          keyboardType: hinttext.toString() == "Enter amount"
              ? TextInputType.phone
              : TextInputType.name,
          controller: controller,
          decoration: InputDecoration(
            // suffixIcon: hinttext.toString() == "Password"
            //     ? Icon(Icons.visibility_off)
            //     : null,
            border: InputBorder.none,
            hintText: hinttext,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: screenHeight * 0.020,
            ),
          ),
        ),
      ),
    );
  }
}
