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
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 200,
                    title: Text("Testing"),
                    stretch: true,
                    backgroundColor: Colors.amber,
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int pdIndex) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 80,
                            color: Colors.white,
                            child: Text(
                              "DATA",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                      },
                      childCount: 10,
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



// chart_components: ^1.0.1