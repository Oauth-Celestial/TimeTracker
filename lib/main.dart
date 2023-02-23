import 'dart:async';
import 'dart:developer';
import 'dart:ui';
import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:timetracker/Controller/InstalledAppController.dart';
import 'package:timetracker/Controller/UserTrackerController.dart';
import 'package:timetracker/Model/InstalledAppModel.dart';
import 'package:timetracker/Screens/DashBoard/Dashboard.dart';
import 'package:timetracker/Screens/DashBoard/Pages/AnimatedDrawer/AnimatedDrawer.dart';
import 'package:timetracker/Screens/DashBoard/Pages/AnimatedDrawer/Drawer.dart';
import 'package:timetracker/Screens/DashBoard/Pages/AppHome/HomePage.dart';

import 'package:timetracker/Screens/SavedDatabasePage.dart';
import 'package:timetracker/Services/AppHelper..dart';
import 'package:timetracker/Services/DataBaseHelper.dart';
import 'package:timetracker/Services/Theme/ThemeManager.dart';
import 'package:timetracker/Services/UserTracker.dart';

Database? database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await DataBaseHelper.instance.initDb("tracker.db");
  database = DataBaseHelper.instance.database;

  MethodChannel platform = MethodChannel('timeTracker');
  platform.invokeMethod("getForegroundPackage");
  await initializeService();

  runApp(MyApp());
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
      androidConfiguration: AndroidConfiguration(
        // this will be executed when app is in foreground or background in separated isolate
        onStart: onStart,

        // auto start service
        autoStart: true,
        isForegroundMode: true,
        initialNotificationTitle: 'Time Tracker',
        initialNotificationContent: 'Tracking app usage time',

        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
          // auto start service
          autoStart: true,

          // this will be executed when app is in foreground in separated isolate
          onForeground: onStart,

          // you have to enable background fetch capability on xcode project
          onBackground: null));
  service.startService();
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  DataBaseHelper.instance.initDb("tracker.db");

  print("service Started");
  Timer.periodic(Duration(milliseconds: 300), (timer) async {
    try {} on PlatformException catch (e) {}

    // try {
    //   List<InstalledAppData> userInstalledApps = [];
    //   List<Application> installedApps =
    //       await DeviceApps.getInstalledApplications(includeAppIcons: true);
    //   List<AppUsageInfo> appUsageInfo =
    //       await AppHelper.instance.getUsageStats();

    //   for (Application app in installedApps) {
    //     for (AppUsageInfo appinfo in appUsageInfo) {
    //       if (app.packageName == appinfo.packageName) {
    //         userInstalledApps.add(InstalledAppData(
    //             appIcon: app is ApplicationWithIcon
    //                 ? CircleAvatar(
    //                     backgroundImage: MemoryImage(app.icon),
    //                   )
    //                 : CircleAvatar(
    //                     backgroundColor: Colors.white,
    //                     child: Text("Error",
    //                         style: TextStyle(color: Colors.white)),
    //                   ),
    //             packageName: app.packageName,
    //             appname: app.appName,
    //             appDuration: appinfo.usage));
    //       }
    //     }
    //   }
    //   DataBaseHelper.instance.saveAllDataToDb(userInstalledApps, "tracker.db");
    // } catch (e) {}
  });

  service.on('stopService').listen((event) {
    service.stopSelf();
  });
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
        return ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
            builder: (context, _) {
              final themeprovider = Provider.of<ThemeProvider>(context);
              print(themeprovider.themeMode);
              return MaterialApp(
                  navigatorObservers: [UserTracker.instance.routeObserver],
                  title: 'Flutter Demo',
                  themeMode: Provider.of<ThemeProvider>(context).themeMode,
                  theme: MyTheme.lightTheme,
                  darkTheme: MyTheme.darkTheme,
                  home: AnimatedDrawer(
                    drawerWiget: DashboardDrawer(),
                    baseWidget: DashBoardPage(),
                  ));
            });
      }),
    );
  }
}


// https://stackoverflow.com/questions/62575091/possible-to-copy-ios-app-store-transition-using-flutter

// https://blog.karenying.com/posts/50-shades-of-dark-mode-gray