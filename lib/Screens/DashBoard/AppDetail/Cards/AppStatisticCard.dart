import 'package:flutter/material.dart';
import 'package:timetracker/Model/AppModel.dart';
import 'package:timetracker/Screens/DashBoard/AppDetail/Cards/AppUsageCard.dart';
import 'package:timetracker/Services/Helpers/FontStyleHelper.dart';
import 'package:timetracker/Services/Theme/ColorConstant.dart';

class AppStatisticsCard extends StatelessWidget {
  double leftPadding = 20;
  AppModelData appdata;
  AppStatisticsCard({required this.appdata});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding, right: leftPadding),
      child: Card(
        elevation: 3,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: EdgeInsets.only(left: leftPadding - 5),
                  child: Text(
                    "App Statistics",
                    style: FontStyleHelper.shared
                        .getPopppinsBold(yellowAccent, 18),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),

                // Todays Usage Section
                AppUsageCard(
                  title: "Today's App Usage",
                  description: appdata.appDuration,
                  hasDivider: true,
                ),
                SizedBox(height: 10),
                AppUsageCard(
                  title: "Today's App Launches",
                  description: appdata.launchCount,
                  hasDivider: true,
                ),
                SizedBox(height: 10),
                AppUsageCard(
                  title: "Maximum Used On ",
                  description: appdata.appDuration,
                  hasDivider: true,
                ),
                SizedBox(height: 10),
                AppUsageCard(
                  title: "Usage Streak",
                  description: appdata.appDuration,
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
