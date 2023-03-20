import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';

class LimitAppUsageController with ChangeNotifier {
  List<Application> installedApps = [];
  bool hasLoadedData = false;

  getAllApps() async {
    installedApps = await DeviceApps.getInstalledApplications();
    print(installedApps.length);
    hasLoadedData = true;
    notifyListeners();
  }
}
