import 'dart:ffi';
import 'dart:math';

import 'package:animations/animations.dart';

import 'package:d_chart/d_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:im_animations/im_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:timetracker/Controller/InstalledAppController.dart';
import 'package:timetracker/Helpers/FontStyleHelper.dart';
import 'package:timetracker/Model/DashBoardCardModel.dart';
import 'package:timetracker/Model/DoughnutDataModel%20.dart';
import 'package:timetracker/Model/InstalledAppModel.dart';
import 'package:timetracker/Model/PieDataModel.dart';
import 'package:timetracker/Screens/DashBoard/Pages/AnimatedDrawer/Drawer.dart';
import 'package:timetracker/Screens/DashBoard/Pages/AppDetail/AppDetail.dart';
import 'package:timetracker/Helpers/ColorHelper.dart';
import 'package:timetracker/Screens/DashBoard/Pages/DashBoard/DashBoardCard.dart';
import 'package:timetracker/Services/DataBaseHelper.dart';
import 'package:timetracker/Helpers/DateHelper.dart';
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
  List<DashboardCardModel> dashBoardCards = [
    DashboardCardModel(
        lottieFilePath: "assets/work.json",
        cardTitle: "Today's Device Usage",
        cardDesc: "1 Hour 10 Min",
        titleColor: Colors.white,
        descColor: Colors.white),
    DashboardCardModel(
        lottieFilePath: "assets/rocket.json",
        cardTitle: "Top Used Apps",
        cardDesc: "Get Apps You Use The Most",
        titleColor: Colors.white,
        descColor: Colors.white),
    DashboardCardModel(
        lottieFilePath: "assets/apps.json",
        cardTitle: "All Apps",
        cardDesc: "Detailed App Report",
        titleColor: Colors.white,
        descColor: Colors.white)
  ];

  @override
  void initState() {
    // TODO: implement initState

    // platform.invokeMethod("getForegroundPackage",
    //     {"dbPath": DataBaseHelper.instance.dataBasePath});
    Provider.of<InstalledAppController>(context, listen: false).getAppStats();
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
      backgroundColor: darkBackground,
      body: SafeArea(
        child: Container(
          child: Consumer<InstalledAppController>(
              builder: (context, value, child) {
            String timeSpend = DateHelper.instance
                .getFormattedTimeFromSeconds(value.totalScreenTime);

            if (value.hasLoaded) {
              return Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 45,
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 18,
                              ),
                              Text(
                                "Welcome Back To",
                                style: FontStyleHelper.shared
                                    .getPopppinsBold(Colors.white, 28),
                              ),
                            ],
                          )),

                      Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 18,
                              ),
                              Text(
                                "Time Tracker",
                                style: FontStyleHelper.shared
                                    .getPopppinsMedium(Colors.white, 24),
                              ),
                            ],
                          )),

                      // Scrollable(
                      //   viewportBuilder: (context, position) {
                      //     return DashBoardCard(
                      //       scroll: Scrollable.of(context) ?? ScrollableState(),
                      //       lottiePath: "assets/rocket.json",
                      //     );
                      //   },
                      // ),
                      SizedBox(
                        height: 35,
                      ),
                      Scrollable(
                        viewportBuilder: (context, position) {
                          return DashBoardCard(
                            cardData: dashBoardCards[0],
                          );
                        },
                      ).animate().fadeIn(delay: Duration(milliseconds: 400)),
                      SizedBox(
                        height: 20,
                      ),
                      Scrollable(
                        viewportBuilder: (context, position) {
                          return DashBoardCard(
                            cardData: dashBoardCards[1],
                          );
                        },
                      ).animate().fadeIn(delay: Duration(milliseconds: 600)),
                      SizedBox(
                        height: 20,
                      ),
                      Scrollable(
                        viewportBuilder: (context, position) {
                          return DashBoardCard(
                            cardData: dashBoardCards[2],
                          );
                        },
                      ).animate().fadeIn(delay: Duration(milliseconds: 800)),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
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
