import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/foundation.dart';

class InstalledAppController with ChangeNotifier {
  List<Application> installedApps = [];
  bool hasLoaded = false;
  getAllApps() async {
    installedApps =
        await DeviceApps.getInstalledApplications(includeAppIcons: true);
    hasLoaded = true;
    notifyListeners();
  }

  void getUsageStats() async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = endDate.subtract(Duration(hours: 1));
      List<AppUsageInfo> infoList =
          await AppUsage().getAppUsage(startDate, endDate);

      for (var info in infoList) {
        print(info.toString());
      }
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }
}
