import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timetracker/Controller/LimitAppUsageController.dart';
import 'package:timetracker/Screens/DashBoard/DeviceUsage/Cards/DetailPageHeader.dart';
import 'package:timetracker/Screens/DashBoard/LimitAppUsage/InstalledAppCard.dart';
import 'package:timetracker/Services/Helpers/AppHelper..dart';
import 'package:timetracker/Services/Helpers/FontStyleHelper.dart';
import 'package:timetracker/Services/Theme/ColorConstant.dart';

class LimitAppUsage extends StatelessWidget {
  const LimitAppUsage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<LimitAppUsageController>(context, listen: false).getAllApps();
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailPageHeader(
                  title: "Limit App Usage",
                  description:
                      "Maximizing Productivity: Limiting App Usage to Stay Focused",
                  lottiePath: "assets/Meditate.json"),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Installed Apps",
                  style:
                      FontStyleHelper.shared.getPopppinsBold(yellowAccent, 24),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(child: Consumer<LimitAppUsageController>(
                  builder: (context, controller, child) {
                if (controller.hasLoadedData) {
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 2.0 / 1.8),
                      itemCount: controller.installedApps.length,
                      itemBuilder: ((context, index) {
                        return InstalledAppCard(
                          app: controller.installedApps[index],
                        );
                      }));
                } else {
                  return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      color: amber,
                    ),
                  );
                }
              })),
            ],
          ),
        ),
      ),
    );
  }
}
