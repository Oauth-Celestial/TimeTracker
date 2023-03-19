import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timetracker/HelperWidget/FloatingAnimation.dart';
import 'package:timetracker/Model/AppModel.dart';
import 'package:timetracker/Screens/DashBoard/AppDetail/Cards/AppDetailCard.dart';
import 'package:timetracker/Screens/DashBoard/AppDetail/Cards/AppStatisticCard.dart';
import 'package:timetracker/Screens/DashBoard/AppDetail/Cards/AppUsageCard.dart';
import 'package:timetracker/Screens/DashBoard/AppDetail/Cards/EnableFocusModeCard.dart';
import 'package:timetracker/Services/Helpers/AppHelper..dart';
import 'package:timetracker/Services/Helpers/FontStyleHelper.dart';
import 'package:timetracker/Services/Theme/ColorConstant.dart';

class AppDetailPage extends StatefulWidget {
  AppModelData appdata;

  AppDetailPage({required this.appdata});

  @override
  State<AppDetailPage> createState() => _AppDetailPageState();
}

class _AppDetailPageState extends State<AppDetailPage> {
  double leftPadding = 15;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        title: Text("App Detail"),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          children: [
            AppDetailCard(
              appData: widget.appdata,
            ).animate().fadeIn(delay: Duration(milliseconds: 700)).moveY(
                delay: Duration(
                  milliseconds: 800,
                ),
                begin: 400.0,
                end: 0),
            SizedBox(
              height: 10,
            ),
            AppStatisticsCard(
              appdata: widget.appdata,
            ).animate().fadeIn(delay: Duration(milliseconds: 1200)),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: leftPadding, right: leftPadding),
              child: Container(
                child: Card(
                  shadowColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: Colors.black,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: leftPadding),
                            child: Text(
                              "Limit App Usage",
                              style: FontStyleHelper.shared
                                  .getPopppinsBold(yellowAccent, 18),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          AppUsageCard(
                            title: "Limit Access",
                            description: "Set app usage duration for day",
                            hasDivider: true,
                            showButton: true,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          EnableFocusMode(
                            title: "Focus Mode",
                            description: "Add App To Focus Mode",
                            showButton: true,
                            hasDivider: true,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
