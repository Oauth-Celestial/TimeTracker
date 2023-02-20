import 'dart:ffi';
import 'dart:math';

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
import 'package:timetracker/Screens/DashBoard/Pages/AnimatedDrawer/AnimatedDrawer.dart';
import 'package:timetracker/Screens/DashBoard/Pages/AppDetail/AppDetail.dart';
import 'package:timetracker/Services/ColorHelper.dart';
import 'package:timetracker/Services/DateHelper.dart';
import 'package:timetracker/Services/Theme/ColorConstant.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage>
    with SingleTickerProviderStateMixin {
  bool isDrawerOpen = false;
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> scaleanimation;
  @override
  void initState() {
    // TODO: implement initState
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..addListener(() {
            setState(() {});
          });
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
    scaleanimation = Tween<double>(begin: 1, end: 0.9).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
    Provider.of<InstalledAppController>(context, listen: false).getAllApps();
    Provider.of<InstalledAppController>(context, listen: false).getAppStats();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Consumer<InstalledAppController>(
              builder: (context, value, child) {
            print(isDrawerOpen);
            String timeSpend = DateHelper.instance
                .getFormattedTimeFromSeconds(value.totalScreenTime);
            List<PieChartDataModel> data = value.pieData;
            if (value.hasLoaded) {
              return Stack(
                children: [
                  AnimatedPositioned(
                    curve: Curves.fastOutSlowIn,
                    duration: Duration(milliseconds: 200),
                    left: isDrawerOpen ? 0 : -260,
                    width: 260,
                    height: MediaQuery.of(context).size.height,
                    child: AnimatedDrawer(
                      color: darkBackground,
                    ),
                  ),
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(
                          animation.value - 30 * animation.value * pi / 180),
                    child: Transform.translate(
                      offset: Offset(animation.value * 260, 0),
                      child: Transform.scale(
                        scale: scaleanimation.value,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: darkBackground,
                            child: ListView(
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
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              data: value.graphData
                                                  .map((e) => e.toJson())
                                                  .toList(),
                                              fillColor: (pieData, index) =>
                                                  getRandomColor(),
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
                                            ).animate().fadeIn(
                                                delay: Duration(seconds: 1))
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                child: Text("Todays App Usage",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
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
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
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
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 20,
                    child: InkWell(
                      onTap: () {
                        if (isDrawerOpen) {
                          animationController.reverse();
                        } else {
                          animationController.forward();
                        }
                        setState(() {
                          isDrawerOpen = !isDrawerOpen;
                        });
                      },
                      child: ClipOval(
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.white,
                          child: Icon(
                            Icons.alarm,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  )
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