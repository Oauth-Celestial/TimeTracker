import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:timetracker/Screens/POC/AppHome/HomePage.dart';
import 'package:timetracker/Services/Theme/ColorConstant.dart';
import 'package:timetracker/Services/Theme/ThemeSwitch.dart';

class DashboardDrawer extends StatefulWidget {
  const DashboardDrawer({super.key});

  @override
  State<DashboardDrawer> createState() => _DashboardDrawerState();
}

class _DashboardDrawerState extends State<DashboardDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        width: 260,
        height: double.infinity,
        child: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Dark Mode",
                  style: TextStyle(color: whiteText, fontSize: 18),
                ),
                Expanded(
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: themeSwitch(context)))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(children: [
              SizedBox(
                width: 10,
              ),
              OpenContainer(
                closedColor: Colors.transparent,
                openColor: Colors.transparent,
                openBuilder: ((context, action) {
                  return Container();
                }),
                closedBuilder: (context, action) {
                  return Text(
                    "All Apps",
                    style: TextStyle(color: whiteText, fontSize: 18),
                  );
                },
              ),
            ])
          ],
        ),
      ),
    );
  }
}
