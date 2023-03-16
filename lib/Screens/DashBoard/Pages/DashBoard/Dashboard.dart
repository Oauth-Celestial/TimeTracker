import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/Controller/DeviceUsageController.dart';
import 'package:timetracker/Controller/InstalledAppController.dart';
import 'package:timetracker/Services/Helpers/FontStyleHelper.dart';
import 'package:timetracker/Model/DashBoardCardModel.dart';
import 'package:timetracker/Screens/DashBoard/Pages/DashBoard/DashBoardCard.dart';
import 'package:timetracker/Services/Helpers/DataBaseHelper.dart';
import 'package:timetracker/Services/Helpers/DateHelper.dart';
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
        titleColor: whiteText,
        descColor: whiteText,
        shouldUpdate: true),
    DashboardCardModel(
        lottieFilePath: "assets/Meditate.json",
        cardTitle: "Limit App Usage",
        cardDesc: "Maximizing Productivity: Limiting App Usage to Stay Focused",
        titleColor: whiteText,
        descColor: whiteText,
        shouldUpdate: false),
    DashboardCardModel(
        lottieFilePath: "assets/Report.json",
        cardTitle: "App Report",
        cardDesc:
            "App Usage Analysis: Insights and Recommendations for Managing Screen Time",
        titleColor: whiteText,
        descColor: whiteText,
        shouldUpdate: false)
  ];

  @override
  void initState() {
    // TODO: implement initState

    platform.invokeMethod("getForegroundPackage",
        {"dbPath": DataBaseHelper.instance.dataBasePath});
    //Provider.of<InstalledAppController>(context, listen: false).getAppStats();
    String todaysDate = DateHelper.instance.getTodaysFormattedDate();
    DataBaseHelper.instance.getAllRecords(todaysDate);
    Provider.of<DeviceUsageController>(context, listen: false)
        .getTotalDeviceUsage(todaysDate);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
                          height: 25,
                        ),

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
                                      .getPopppinsRegular(whiteText, 24),
                                ),
                              ],
                            )),

                        Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "Good Evening",
                                  style: FontStyleHelper.shared
                                      .getPopppinsBold(whiteText, 28),
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
                          height: 20,
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
      ),
    );
  }
}

// chart_components: ^1.0.1
