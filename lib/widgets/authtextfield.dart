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
      height: 55,
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
        child: Center(
          child: TextField(
            keyboardType: hinttext.toString() == "Enter amount" ||
                    hinttext.toString() == "Phone number"
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
                fontWeight: FontWeight.w400,
                color: Colors.grey,
                fontSize: screenHeight * 0.020,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
