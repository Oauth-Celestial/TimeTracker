import 'package:app_usage/app_usage.dart';

class AppHelper {
  static AppHelper instance = AppHelper();

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
