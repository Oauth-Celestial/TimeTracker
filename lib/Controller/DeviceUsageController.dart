import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:timetracker/Services/Helpers/DataBaseHelper.dart';

class DeviceUsageController with ChangeNotifier {
  Timer? timer;

  String appUsage = "";

  updateAppUsage(String date) async {
    appUsage = await DataBaseHelper.instance.getDeviceUsage(date);
    notifyListeners();
  }

  getTotalDeviceUsage(String date) async {
    timer =
        Timer.periodic(Duration(seconds: 1), (Timer t) => updateAppUsage(date));
  }
}
