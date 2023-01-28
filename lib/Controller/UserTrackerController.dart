import 'package:flutter/cupertino.dart';
import 'package:timetracker/Services/UserTracker.dart';

class UserTrackerController with ChangeNotifier {
  int timeSpend = 0;
  updateTimeSpend() {
    timeSpend = UserTracker.instance.seconds;
    notifyListeners();
  }

  String getFormattedTime() {
    final duration = Duration(seconds: timeSpend);
    return duration.format();
  }
}

extension on Duration {
  String format() => '$this'.split('.')[0].padLeft(8, '0');
}
