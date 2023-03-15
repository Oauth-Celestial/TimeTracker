import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';

class AppHelper {
  static AppHelper instance = AppHelper();

  Future<Widget> getAppIconFromPackage(String appPackageName) async {
    Application? app = await DeviceApps.getApp(appPackageName, true);
    return Image.memory((app as ApplicationWithIcon).icon);
  }
}
