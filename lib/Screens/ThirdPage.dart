import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/Controller/RouteHandler.dart';
import 'package:timetracker/Controller/UserTrackerController.dart';
import 'dart:math' as math;

import 'package:timetracker/Services/UserTracker.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> with ScreenTimeHandler {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    UserTracker.instance.startScreenTracker(this.runtimeType.toString());
    UserTracker.instance.routeObserver
        .subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    UserTracker.instance.routeObserver.unsubscribe(this);
    // UserTracker.instance.stopScreenTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(1.0),
        appBar: AppBar(
          title: Text("Time Spent"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Consumer<UserTrackerController>(
                    builder: ((context, value, child) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text(
                      value.getScreenFormattedTime(),
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  );
                }))
              ],
            ),
          ),
        ));
  }
}
