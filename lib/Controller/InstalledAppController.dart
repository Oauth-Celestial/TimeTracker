import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_settings/open_settings.dart';
import 'package:timetracker/Model/InstalledAppModel.dart';

class InstalledAppController with ChangeNotifier {
  List<InstalledAppData> userInstalledApps = [];
  bool hasLoaded = false;

  getAllApps() async {
    userInstalledApps.clear();
    List<Application> installedApps =
        await DeviceApps.getInstalledApplications(includeAppIcons: true);
    List<AppUsageInfo> appUsageInfo = await getUsageStats();

    for (Application app in installedApps) {
      for (AppUsageInfo appinfo in appUsageInfo) {
        if (app.packageName == appinfo.packageName) {
          userInstalledApps.add(InstalledAppData(
              appIcon: app is ApplicationWithIcon
                  ? CircleAvatar(
                      backgroundImage: MemoryImage(app.icon),
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.white,
                      child:
                          Text("Error", style: TextStyle(color: Colors.white)),
                    ),
              packageName: app.packageName,
              appname: app.appName,
              appDuration: appinfo.usage));
        }
      }
    }
    userInstalledApps.sort((b, a) => a.appDuration.compareTo(b.appDuration));
    hasLoaded = true;
    notifyListeners();
  }

  refreshList() {
    hasLoaded = false;
    userInstalledApps.clear();
    notifyListeners();
    getAllApps();
  }

  Future<List<AppUsageInfo>> getUsageStats() async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = endDate.subtract(Duration(hours: 1));
      List<AppUsageInfo> infoList =
          await AppUsage().getAppUsage(startDate, endDate);

      // for (var info in infoList) {
      //   print(info.toString());
      // }
      return infoList;
    } on AppUsageException catch (exception) {
      print(exception);
      return [];
    }
  }
}
