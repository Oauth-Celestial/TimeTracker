import 'package:app_usage/app_usage.dart';
import 'package:flutter/material.dart';
import 'package:timetracker/Model/CardDataModel.dart';
import 'package:usage_stats/usage_stats.dart';

class InstalledAppController with ChangeNotifier {
  bool hasLoaded = true;

  int totalScreenTime = 0;

  List<CardDataModel> cardData = [
    CardDataModel(
        icon: Icon(
          Icons.apps,
          size: 60,
        ),
        title: "All Apps"),
    CardDataModel(
        icon: Icon(Icons.auto_graph_rounded, size: 60), title: "App Usage"),
    CardDataModel(
        icon: Icon(Icons.arrow_upward, size: 60), title: "Top Usage Apps"),
    CardDataModel(
        icon: Icon(Icons.arrow_downward, size: 60), title: "Least Used Apps")
  ];

  getAllApps() async {
    totalScreenTime = 0;
    hasLoaded = false;
    totalScreenTime = 0;
    // Application? app = await DeviceApps.getApp('com.frandroid.app');

    hasLoaded = true;
    // notifyListeners();
  }

  refreshList() {
    hasLoaded = false;

    notifyListeners();
    getAllApps();
  }

  // getAllData() async {
  //   List<Map> alldata = await DataBaseHelper.instance.getAllRecords();
  //   data = alldata.map((e) => appData.fromJson(e)).toList();
  // }

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

  getAppStats() async {
    DateTime endDate = new DateTime.now();
    DateTime startDate =
        DateTime(endDate.year, endDate.month, endDate.day, 0, 0, 0);
    List<UsageInfo> usageStats =
        await UsageStats.queryUsageStats(startDate, endDate);
    print(usageStats);

    // Map<String, UsageInfo> queryAndAggregateUsageStats =
    //     await UsageStats.queryAndAggregateUsageStats(startDate, endDate);
    // print(queryAndAggregateUsageStats);

    // for (var i in usageStats) {
    //   if (double.parse(i.totalTimeInForeground!) > 0) {
    //     //print(i.packageName);
    //     DateTime appInstalledDate =
    //         DateTime.fromMillisecondsSinceEpoch(int.parse(i.firstTimeStamp!));
    //     print(DateHelper.instance.formatDateToYearMonthDate(appInstalledDate));

    //     // print(appInstalledDate);
    //     DateTime lastUsedAt =
    //         DateTime.fromMillisecondsSinceEpoch(int.parse(i.lastTimeStamp!));

    //     int totalScreenTime =
    //         ((int.parse(i.totalTimeInForeground!) ~/ 1000) ~/ 60).toInt();
    //   }
    // }
  }
}
