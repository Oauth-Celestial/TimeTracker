import 'package:intl/intl.dart';
import 'package:timetracker/Model/InstalledAppModel.dart';

class DateHelper {
  static DateHelper instance = DateHelper();

  getFormattedDbDate(DateTime date) {
    final DateTime now = date;
    return "${now.year}-${now.month}-${now.day}";
  }

  String getFormattedAppUsage(InstalledAppData app) {
    String appUsed = getFormattedTimeFromSeconds(app.appDuration.inSeconds);
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

    if (h > 0) {
      result = "$hourLeft Hours $minuteLeft Min $secondsLeft sec ";
    } else {
      if (m < 1) {
        result = "$secondsLeft sec";
      } else {
        result = "$minuteLeft Min $secondsLeft sec";
      }
    }

    return result;
  }

  String getTodaysFormattedDate() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy/MM/dd').format(now);
    return formattedDate;
  }

  String formatDateToYearMonthDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
}
