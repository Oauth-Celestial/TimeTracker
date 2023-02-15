import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:timetracker/Screens/DashBoard/Pages/AppHome/AppHome.dart';
import 'package:timetracker/Screens/DashBoard/Pages/AppsPage.dart';
import 'package:timetracker/Screens/DashBoard/Pages/SettingsPage.dart';
import 'package:timetracker/Screens/DashBoard/Pages/StatisticsPage.dart';

class DashBoardPage extends StatefulWidget {
  @override
  State createState() {
    return _DashBoardPage();
  }
}

class _DashBoardPage extends State {
  Widget? _child;

  @override
  void initState() {
    _child = AppHomePage();
    super.initState();
  }

  @override
  Widget build(context) {
    // Build a simple container that switches content based of off the selected navigation item
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        body: _child,
        bottomNavigationBar: FluidNavBar(
          icons: [
            FluidNavBarIcon(
                icon: Icons.dashboard,
                backgroundColor: Colors.white,
                extras: {"label": "dashboard"}),
            FluidNavBarIcon(
                icon: Icons.report,
                backgroundColor: Colors.white,
                extras: {"label": "Statistics"}),
            FluidNavBarIcon(
                icon: Icons.settings,
                backgroundColor: Colors.white,
                extras: {"label": "Settings"}),
          ],
          onChange: _handleNavigationChange,
          style: FluidNavBarStyle(
              iconUnselectedForegroundColor: Colors.black,
              iconSelectedForegroundColor: Colors.blueAccent,
              barBackgroundColor: Theme.of(context).primaryColor),
          scaleFactor: 1.5,
          defaultIndex: 0,
          itemBuilder: (icon, item) => Semantics(
            label: icon.extras!["label"],
            child: item,
          ),
        ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = AppHomePage();
          break;
        case 1:
          _child = StatisticsPage();
          break;
        case 2:
          _child = SettingsPage();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        child: _child,
      );
    });
  }
}
