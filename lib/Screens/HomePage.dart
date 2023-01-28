import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/Controller/UserTrackerController.dart';
import 'package:timetracker/Services/UserTracker.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserTracker.instance.startTimer(context);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      UserTracker.instance.startTimer(context);

      print("Resumed");
    } else if (state == AppLifecycleState.paused) {
      UserTracker.instance.pauseTimer(context);
      print("Paused");
    } else if (state == AppLifecycleState.inactive) {
      UserTracker.instance.pauseTimer(context);
      print("inactive");
    }
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
                      value.getFormattedTime(),
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
