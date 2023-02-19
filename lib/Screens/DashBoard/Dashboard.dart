import 'package:animations/animations.dart';
import 'package:d_chart/d_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:timetracker/Controller/InstalledAppController.dart';
import 'package:timetracker/Model/DoughnutDataModel%20.dart';
import 'package:timetracker/Model/InstalledAppModel.dart';
import 'package:timetracker/Model/PieDataModel.dart';
import 'package:timetracker/Screens/DashBoard/Pages/AppDetail/AppDetail.dart';
import 'package:timetracker/Services/ColorHelper.dart';
import 'package:timetracker/Services/DateHelper.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<InstalledAppController>(context, listen: false).getAllApps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Welcome",
          style: TextStyle(fontSize: 23),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Consumer<InstalledAppController>(
              builder: (context, value, child) {
            String timeSpend = DateHelper.instance
                .getFormattedTimeFromSeconds(value.totalScreenTime);
            List<PieChartDataModel> data = value.pieData;
            if (value.hasLoaded) {
              return ListView(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 300,
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Stack(
                            children: [
                              DChartPie(
                                animationDuration: Duration(seconds: 1),
                                data: value.graphData
                                    .map((e) => e.toJson())
                                    .toList(),
                                fillColor: (pieData, index) => getRandomColor(),
                                donutWidth: 15,
                                strokeWidth: 5,
                                pieLabel: (pieData, index) {
                                  return "";
                                },
                                labelColor: Colors.white,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: AspectRatio(
                                  aspectRatio: 8 / 2.3,
                                  child: Lottie.asset(
                                    "assets/phone.json",
                                  ),
                                ),
                              ).animate().fadeIn(delay: Duration(seconds: 1))
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: Text("Todays App Usage",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(timeSpend,
                                      style: TextStyle(
                                          color: Colors.amber,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  // Container(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(20.0),
                  //     child: GridView.count(
                  //         crossAxisCount: 2,
                  //         crossAxisSpacing: 10.0,
                  //         mainAxisSpacing: 10.0,
                  //         physics: NeverScrollableScrollPhysics(),
                  //         shrinkWrap: true,
                  //         children: List.generate(
                  //           value.cardData.length,
                  //           (index) {

                  //             return InkWell(
                  //               onTap: (){

                  //               },
                  //               child: ClipRRect(
                  //                 borderRadius: BorderRadius.circular(10),
                  //                 child: Container(
                  //                   color: Colors.black,
                  //                   child: Column(
                  //                     mainAxisAlignment: MainAxisAlignment.center,
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.center,
                  //                     children: [
                  //                       value.cardData[index].icon ?? Container(),
                  //                       SizedBox(
                  //                         height: 40,
                  //                       ),
                  //                       Text(
                  //                         value.cardData[index].title ?? "",
                  //                         style: TextStyle(
                  //                             color: Colors.amber,
                  //                             fontWeight: FontWeight.bold,
                  //                             fontSize: 18),
                  //                       )
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //             );
                  //           },
                  //         )),
                  //   ),
                  // ),
                  SizedBox(
                    height: 20,
                  ),

                  for (int i = 0; i < value.userInstalledApps.length; i++) ...[
                    DashboardListCard(
                      app: value.userInstalledApps[i],
                    )
                  ]
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