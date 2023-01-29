import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetracker/Services/UserTracker.dart';
// https://quickbirdstudios.com/blog/flutter-dart-mixins/

mixin ScreenTimeHandler implements RouteAware {
  @override
  void didPush() {}

  @override
  void didPop() {}

  void didPopNext() {
    print(this.runtimeType.toString());
    UserTracker.instance.startScreenTracker(this.runtimeType.toString());
    print('SecondPage: Called didPopNext');
  }

  @override
  void didPushNext() {
    print(this.runtimeType.toString());
    UserTracker.instance.stopScreenTimer();
    print('SecondPage: Called didPushNext');
  }

  void hadNavigatedToNextPage() {}
}
