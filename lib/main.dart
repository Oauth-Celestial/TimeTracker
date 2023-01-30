import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/Controller/InstalledAppController.dart';
import 'package:timetracker/Controller/UserTrackerController.dart';
import 'package:timetracker/Screens/HomePage.dart';
import 'package:timetracker/Screens/InstalledAppsPage.dart';
import 'package:timetracker/Services/UserTracker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserTrackerController()),
        ChangeNotifierProvider(create: (_) => InstalledAppController())
      ],
      builder: ((context, child) {
        return MaterialApp(
          navigatorObservers: [UserTracker.instance.routeObserver],
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: InstalledApps(),
        );
      }),
    );
  }
}
