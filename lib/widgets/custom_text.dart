import 'package:flutter/material.dart';
import 'package:invoice_maker/utils/colors.dart';

class KText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;
  final String? fontFamily;
  final TextAlign? textAlign;

  const KText({
    Key? key,
    required this.text,
    this.fontSize = 16,
    this.color,
    this.fontWeight = FontWeight.normal,
    this.fontFamily,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        color: color ?? AppColors.primaryfontColor,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
      ),
    );
  }
}
