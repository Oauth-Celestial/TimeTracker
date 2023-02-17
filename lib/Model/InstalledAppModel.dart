import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InstalledAppData {
  String appname;
  String packageName;
  Widget appIcon;
  Duration appDuration;
  Uint8List? bytes;

  InstalledAppData(
      {required this.appIcon,
      required this.packageName,
      required this.appname,
      required this.appDuration,
      this.bytes});
}

class appData {
  final String packageName;
  final String duration;
  final String updatedOn;

  appData(this.packageName, this.duration, this.updatedOn);

  factory appData.fromJson(Map json) {
    List<dynamic> values = json.values.toList();
    return appData(values[1], "${values[2]}", values[3]);
  }
}
