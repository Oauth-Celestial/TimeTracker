import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/Controller/UserTrackerController.dart';
import 'package:timetracker/Services/UserTracker.dart';

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
        body: SafeArea(
      child: Container(
        child: Column(
          children: [
            Consumer<UserTrackerController>(builder: ((context, value, child) {
              return Container(
                child: Text(
                  "${value.timeSpend}",
                  style: TextStyle(color: Colors.black),
                ),
              );
            }))
          ],
        ),
      ),
    ));
  }
}
