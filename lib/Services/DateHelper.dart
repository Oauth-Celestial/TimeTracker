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

  String getFormattedTimeFromSeconds(int value) {
    int h, m, s;

    h = value ~/ 3600;

    m = ((value - h * 3600)) ~/ 60;

    s = value - (h * 3600) - (m * 60);

    String hourLeft =
        h.toString().length < 2 ? "0" + h.toString() : h.toString();

    String minuteLeft =
        m.toString().length < 2 ? "0" + m.toString() : m.toString();

    String secondsLeft =
        s.toString().length < 2 ? "0" + s.toString() : s.toString();

    String result = "";

    if (h >= 0) {
      result = "$hourLeft Hours $minuteLeft Min ";
    } else {
      result = "$minuteLeft Min";
    }

    return result;
  }
}
