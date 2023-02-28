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
import 'package:timetracker/Controller/OnBoardingController.dart';
import 'package:timetracker/Controller/UserTrackerController.dart';
import 'package:timetracker/Model/InstalledAppModel.dart';
import 'package:timetracker/Screens/DashBoard/Dashboard.dart';
import 'package:timetracker/Screens/DashBoard/Pages/AnimatedDrawer/AnimatedDrawer.dart';
import 'package:timetracker/Screens/DashBoard/Pages/AnimatedDrawer/Drawer.dart';
import 'package:timetracker/Screens/OnboardingScreen/OnboardingHome.dart';
import 'package:timetracker/Screens/OnboardingScreen/UsageAccessPage.dart';
import 'package:timetracker/Screens/SplashScreen/SplashScreen.dart';

import 'package:timetracker/Services/DataBaseHelper.dart';
import 'package:timetracker/Services/Theme/ThemeManager.dart';
import 'package:timetracker/Services/UserTracker.dart';

Database? database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataBaseHelper.instance.initDb("tracker.db");
  database = DataBaseHelper.instance.database;

  MethodChannel platform = MethodChannel(
    'timeTracker',
  );
  // platform.invokeMethod(
  //     "getForegroundPackage", {"dbPath": DataBaseHelper.instance.dataBasePath});
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
        ChangeNotifierProvider(create: (_) => InstalledAppController()),
        ChangeNotifierProvider(create: (_) => OnBoardingController())
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
                  home: OnboardingPage()

                  // AnimatedDrawer(
                  //   drawerWiget: DashboardDrawer(),
                  //   baseWidget: DashBoardPage(),
                  // )

                  );
            });
      }),
    );
  }
}


// https://stackoverflow.com/questions/62575091/possible-to-copy-ios-app-store-transition-using-flutter

// https://blog.karenying.com/posts/50-shades-of-dark-mode-gray


// https://gist.github.com/paulo-raca/471680c0fe4d8f91b8cde486039b0dcd

// https://medium.com/flutter-community/everything-you-need-to-know-about-flutter-page-route-transition-9ef5c1b32823