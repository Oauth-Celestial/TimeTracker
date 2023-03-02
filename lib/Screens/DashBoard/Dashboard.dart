import 'dart:ffi';
import 'dart:math';

import 'package:animations/animations.dart';
import 'package:d_chart/d_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:timetracker/Controller/InstalledAppController.dart';
import 'package:timetracker/Model/DoughnutDataModel%20.dart';
import 'package:timetracker/Model/InstalledAppModel.dart';
import 'package:timetracker/Model/PieDataModel.dart';
import 'package:timetracker/Screens/DashBoard/Pages/AnimatedDrawer/Drawer.dart';
import 'package:timetracker/Screens/DashBoard/Pages/AppDetail/AppDetail.dart';
import 'package:timetracker/Services/ColorHelper.dart';
import 'package:timetracker/Services/DataBaseHelper.dart';
import 'package:timetracker/Services/DateHelper.dart';
import 'package:timetracker/Services/Theme/ColorConstant.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage>
    with SingleTickerProviderStateMixin {
  MethodChannel platform = MethodChannel(
    'timeTracker',
  );
  @override
  void initState() {
    // TODO: implement initState

    platform.invokeMethod("getForegroundPackage",
        {"dbPath": DataBaseHelper.instance.dataBasePath});
    // Provider.of<InstalledAppController>(context, listen: false).getAppStats();
    String todaysDate = DateHelper.instance.getTodaysFormattedDate();
    DataBaseHelper.instance.getAllRecords(todaysDate);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Consumer<InstalledAppController>(
              builder: (context, value, child) {
            String timeSpend = DateHelper.instance
                .getFormattedTimeFromSeconds(value.totalScreenTime);
            List<PieChartDataModel> data = value.pieData;
            if (value.hasLoaded) {
              return Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: darkBackground,
                      child: ListView(
                        children: [
                          for (int i = 0;
                              i < value.userInstalledApps.length;
                              i++) ...[
                            DashboardListCard(
                              app: value.userInstalledApps[i],
                            )
                          ]
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}

class DashboardListCard extends StatelessWidget {
  InstalledAppData app;
  DashboardListCard({required this.app});

  @override
  Widget build(BuildContext context) {
    String appTime = DateHelper.instance.getFormattedAppUsage(app);
    return OpenContainer(
      closedColor: Colors.transparent,
      openColor: Colors.transparent,
      openBuilder: ((context, action) {
        return AppDetailPage(app: app);
      }),
      closedBuilder: (context, action) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: Colors.black,
              height: 80,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  app.appIcon,
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        app.appname,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Time Spent :- ${appTime}",
                        style: TextStyle(color: Colors.amber, fontSize: 15),
                      ),
                    ],
                  ),
                  Expanded(
                      child: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.amber,
                    ),
                  )),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
            ),
          ),
        );
      },
    ).animate().scale(delay: Duration(milliseconds: 300));
  }
}

// chart_components: ^1.0.1