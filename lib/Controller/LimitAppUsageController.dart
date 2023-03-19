import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';

class LimitAppUsageController with ChangeNotifier {
  List<Application> installedApps = [];

  getAllApps() async {
    installedApps = await DeviceApps.getInstalledApplications();
    notifyListeners();
  }
}
