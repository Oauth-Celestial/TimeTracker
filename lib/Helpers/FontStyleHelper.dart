import 'package:flutter/material.dart';
import 'package:timetracker/Services/Theme/ColorConstant.dart';

class FontStyleHelper {
  static FontStyleHelper shared = FontStyleHelper();

  TextStyle getPopppinsRegular(Color? fontColor, double fontSize) {
    return TextStyle(
        color: fontColor ?? whiteText,
        fontSize: fontSize,
        fontWeight: FontWeight.w300);
  }

  TextStyle getPopppinsMedium(Color? fontColor, double fontSize) {
    return TextStyle(
        color: fontColor ?? whiteText,
        fontSize: fontSize,
        fontWeight: FontWeight.w500);
  }

  TextStyle getPopppinsBold(Color? fontColor, double fontSize) {
    return TextStyle(
        color: fontColor ?? whiteText,
        fontSize: fontSize,
        fontWeight: FontWeight.w700);
  }
}
