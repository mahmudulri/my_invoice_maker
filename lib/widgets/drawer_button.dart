import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerButtonWidget extends StatelessWidget {
  DrawerButtonWidget({
    super.key,
    this.buttonName,
    this.onpressed,
    this.myicon,
  });

  final String? buttonName;
  final VoidCallback? onpressed;
  final IconData? myicon;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: 10, right: 30),
      height: 40,
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GestureDetector(
          onTap: onpressed,
          child: Row(
            children: [
              FaIcon(
                myicon,
                color: Colors.grey.shade300,
              ),
              SizedBox(
                width: 7,
              ),
              Text(
                buttonName.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.grey.shade300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
