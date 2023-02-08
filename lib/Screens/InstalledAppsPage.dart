import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/Controller/InstalledAppController.dart';
import 'package:timetracker/Model/InstalledAppModel.dart';
import 'package:timetracker/Screens/SavedDatabasePage.dart';
import 'package:timetracker/Services/AppHelper..dart';
import 'package:timetracker/Services/DataBaseHelper.dart';
import 'package:timetracker/Services/Extension.dart';

import 'package:app_usage/app_usage.dart';
import 'package:timetracker/Services/RouteManager.dart';

class InstalledApps extends StatefulWidget {
  const InstalledApps({super.key});

  @override
  State<InstalledApps> createState() => _InstalledAppsState();
}

class _InstalledAppsState extends State<InstalledApps> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Workmanager().initialize(
    //     callbackDispatcher, // The top level function, aka callbackDispatcher
    //     isInDebugMode:
    //         true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
    //     );
    //      // Workmanager().registerOneOffTask(date, "simplePeriodicTask",
    // //     initialDelay: Duration(seconds: 5));

    var date = DateTime.now().toString();

    Provider.of<InstalledAppController>(context, listen: false).getAllApps();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Installed Apps"),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Provider.of<InstalledAppController>(context, listen: false)
                      .refreshList();
                },
                child: Container(
                  child: Icon(Icons.refresh),
                ),
              ),
              SizedBox(
                width: 20,
              )
            ],
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: SafeArea(child:
          Consumer<InstalledAppController>(builder: ((context, value, child) {
        List<InstalledAppData> installedApps = value.userInstalledApps;

        if (value.hasLoaded) {
          return Container(
            child: AnimatedList(
                initialItemCount: installedApps.length,
                itemBuilder: ((context, index, animation) {
                  return slideIt(context, installedApps[index], animation);
                })),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            child: Text(
              "Loading Apps",
              style: TextStyle(color: Colors.white),
            ),
          );
        }
      }))),
    );
  }
}

Widget slideIt(BuildContext context, InstalledAppData app, animation) {
  return InkWell(
    onTap: (() async {
      // DataBaseHelper.instance.getAllRecords();
      await Provider.of<InstalledAppController>(context, listen: false)
          .getAllData();
      RouteManager.instance.push(to: RecordPage(), context: context);
    }),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: ClipRRect(
          child: Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Row(
          children: [
            Container(
              color: Colors.transparent,
              width: 100,
              height: 100,
              alignment: Alignment.center,
              child: ClipRRect(
                child: Container(
                  color: Colors.transparent,
                  width: 60,
                  height: 60,
                  child: app.appIcon,
                ),
              ),
            ).animate().slide(duration: 500.ms),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(app.appname.capiltizeFirstLetter(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold))
                    .animate()
                    .slideX(delay: 350.ms, begin: 10, end: 0, duration: 500.ms),
                SizedBox(
                  height: 20,
                ),
                Text("Time Spent ${app.appDuration.inMinutes} Min",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.normal))
                    .animate()
                    .slideX(delay: 350.ms, begin: 10, end: 0, duration: 500.ms),
              ],
            ),
          ],
        ),
      )),
    ),
  );
}
