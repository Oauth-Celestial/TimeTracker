import 'package:timetracker/Model/InstalledAppModel.dart';

class DateHelper {
  static DateHelper instance = DateHelper();

  getFormattedDbDate(DateTime date) {
    final DateTime now = date;
    return "${now.year}-${now.month}-${now.day}";
  }

  String getFormattedAppUsage(InstalledAppData app) {
    String appUsed = "";
    if (app.appDuration.inHours > 0) {
      appUsed += app.appDuration.inHours.toString() + " Hours ";
    }
    if (app.appDuration.inMinutes > 0) {
      appUsed += (app.appDuration.inMinutes > 60
                  ? app.appDuration.inMinutes - 60
                  : app.appDuration.inMinutes)
              .toString() +
          " Min";
    }
    if (app.appDuration.inMinutes < 2 && app.appDuration.inHours <= 0) {
      appUsed = "< 1 min";
    }
    return appUsed;
  }
}
