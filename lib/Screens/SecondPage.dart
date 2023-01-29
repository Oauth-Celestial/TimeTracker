import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/Controller/RouteHandler.dart';
import 'dart:math' as math;
import 'package:timetracker/Controller/UserTrackerController.dart';
import 'package:timetracker/Screens/ThirdPage.dart';
import 'package:timetracker/Services/RouteManager.dart';
import 'package:timetracker/Services/UserTracker.dart';

class SecondPage extends StatefulWidget with ScreenTimeHandler {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> with ScreenTimeHandler {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    UserTracker.instance.startScreenTracker(this.runtimeType.toString());
    UserTracker.instance.routeObserver
        .subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void initState() {
    // TODO: implement initState
    UserTracker.instance.startScreenTracker(this.runtimeType.toString());
    super.initState();
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
                })),
                InkWell(
                  onTap: (() {
                    RouteManager.instance
                        .push(to: ThirdPage(), context: context);
                  }),
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
