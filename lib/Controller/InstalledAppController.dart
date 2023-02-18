import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_settings/open_settings.dart';
import 'package:timetracker/Model/InstalledAppModel.dart';
import 'package:timetracker/Model/PieDataModel.dart';
import 'package:timetracker/Services/DataBaseHelper.dart';
import 'package:timetracker/Services/DateHelper.dart';

class InstalledAppController with ChangeNotifier {
  List<InstalledAppData> userInstalledApps = [];
  bool hasLoaded = false;
  List<appData> data = [];
  List<PieChartDataModel> pieData = [];
  int totalScreenTime = 0;

  getAllApps() async {
    userInstalledApps.clear();
    pieData.clear();
    totalScreenTime = 0;
    hasLoaded = false;
    totalScreenTime = 0;
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
              lastUsedOn: appinfo.lastForeground,
              bytes: (app as ApplicationWithIcon).icon,
              appDuration: appinfo.usage));
          // pieData.add(PieChartDataModel(
          //     title: DateHelper.instance
          //         .getFormattedTimeFromSeconds(appinfo.usage.inSeconds),
          //     value: (app as ApplicationWithIcon).icon));
          pieData.add(PieChartDataModel(
              title: "",
              value: appinfo.usage.inSeconds.toDouble,
              bytes: (app as ApplicationWithIcon).icon));
          totalScreenTime += appinfo.usage.inSeconds;
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

  getAllData() async {
    List<Map> alldata = await DataBaseHelper.instance.getAllRecords();
    data = alldata.map((e) => appData.fromJson(e)).toList();
    print(data.length);
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
