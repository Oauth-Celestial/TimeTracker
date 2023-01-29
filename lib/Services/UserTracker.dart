import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/Controller/UserTrackerController.dart';

class UserTracker {
  static UserTracker instance = UserTracker();

  int seconds = 0;
  var timer;
  var screenTimer;
  Map<String, int> screensUsedTimer = {};
  RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

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

  startScreenTracker(String className) {
    if (!screensUsedTimer.containsKey(className)) {
      screensUsedTimer[className] = 0;
    }
    if (screenTimer == null || screenTimer.isActive) {
      if (screenTimer == null) {
        screenTimer = Timer.periodic(Duration(seconds: 1), (value) {
          print(screensUsedTimer);
          screensUsedTimer[className] =
              (screensUsedTimer[className] as int) + 1;
          print(screensUsedTimer[className]);
          // Provider.of<UserTrackerController>(context, listen: false)
          //     .updateScreenTime(className);
        });
      }

      if (screenTimer.isActive) {
        screenTimer.cancel();
        screenTimer = Timer.periodic(Duration(seconds: 1), (value) {
          print(screensUsedTimer);
          screensUsedTimer[className] =
              (screensUsedTimer[className] as int) + 1;
          print(screensUsedTimer[className]);
          // Provider.of<UserTrackerController>(context, listen: false)
          //     .updateScreenTime(className);
        });
      }
    }

    if (!(screenTimer)?.isActive) {
      screenTimer = Timer.periodic(Duration(seconds: 1), (value) {
        print(screensUsedTimer);
        screensUsedTimer[className] = (screensUsedTimer[className] as int) + 1;
        print(screensUsedTimer[className]);
        // Provider.of<UserTrackerController>(context, listen: false)
        //     .updateScreenTime(className);
      });
    }

    print("Executed");
  }

  stopScreenTimer() {
    print("Stopped Timer");
    screenTimer.cancel();
  }
}
