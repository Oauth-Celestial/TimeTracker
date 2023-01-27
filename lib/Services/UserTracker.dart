import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/Controller/UserTrackerController.dart';

class UserTracker {
  static UserTracker instance = UserTracker();

  int seconds = 0;
  var timer;

  startTimer(BuildContext context) {
    timer = Timer.periodic(Duration(seconds: 1), (value) {
      seconds += 1;
      Provider.of<UserTrackerController>(context, listen: false)
          .updateTimeSpend();
    });
  }

  pauseTimer(BuildContext context) async {
    print("Timer Stopped");
    timer.cancel();

    DateTime todaysDate = DateTime.now();
    String date = "${todaysDate.day}-${todaysDate.month}-${todaysDate.year}";
  }
}
