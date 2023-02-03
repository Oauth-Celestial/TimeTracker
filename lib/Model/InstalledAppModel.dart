import 'package:flutter/material.dart';

class InstalledAppData {
  String appname;
  String packageName;
  Widget appIcon;
  Duration appDuration;

  InstalledAppData(
      {required this.appIcon,
      required this.packageName,
      required this.appname,
      required this.appDuration});
}
