import 'package:flutter/animation.dart';

class DashboardCardModel {
  String lottieFilePath;
  String cardTitle;
  String cardDesc;
  Color titleColor;
  Color descColor;

  DashboardCardModel(
      {required this.lottieFilePath,
      required this.cardTitle,
      required this.cardDesc,
      required this.titleColor,
      required this.descColor});
}
