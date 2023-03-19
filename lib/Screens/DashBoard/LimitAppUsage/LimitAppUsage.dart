import 'package:flutter/material.dart';
import 'package:timetracker/Screens/DashBoard/DeviceUsage/Cards/DetailPageHeader.dart';
import 'package:timetracker/Services/Theme/ColorConstant.dart';

class LimitAppUsage extends StatelessWidget {
  const LimitAppUsage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              DetailPageHeader(
                  title: "Limit App Usage",
                  description:
                      "Maximizing Productivity: Limiting App Usage to Stay Focused",
                  lottiePath: "assets/Meditate.json"),
              Expanded(child: ListView.builder(itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    color: Colors.yellow,
                  ),
                );
              }))),
            ],
          ),
        ),
      ),
    );
  }
}
