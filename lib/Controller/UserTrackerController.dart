import 'package:flutter/cupertino.dart';
import 'package:timetracker/Services/UserTracker.dart';

class UserTrackerController with ChangeNotifier {
  int timeSpend = 0;
  updateTimeSpend() {
    timeSpend = UserTracker.instance.seconds;
    notifyListeners();
  }
}
