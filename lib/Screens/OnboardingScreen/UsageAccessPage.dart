import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timetracker/Screens/DashBoard/Dashboard.dart';
import 'package:timetracker/Services/RouteManager.dart';
import 'package:timetracker/Services/TextConstant/TextConstant.dart';
import 'package:usage_stats/usage_stats.dart';

class UsageAcessPage extends StatelessWidget {
  const UsageAcessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: LottieBuilder.asset("assets/phone.json")),
              ).animate().fadeIn(delay: Duration(milliseconds: 400)),
              Shimmer.fromColors(
                baseColor: Colors.amber,
                highlightColor: Colors.yellow,
                child: Text(
                  'Usage Permission',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  appUsagePermissionText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ).animate().fadeIn(delay: Duration(milliseconds: 600)),
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: InkWell(
                  onTap: () async {
                    if (!(await UsageStats.checkUsagePermission() ?? false)) {
                      UsageStats.grantUsagePermission();
                    } else {
                      RouteManager.instance
                          .push(to: DashBoardPage(), context: context);
                    }
                  },
                  child: Container(
                    width: 280,
                    height: 50,
                    alignment: Alignment.center,
                    color: Colors.amber,
                    child: Text(
                      "Allow",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
                  .animate()
                  .fadeIn(delay: Duration(milliseconds: 700))
                  .slideX(delay: Duration(milliseconds: 800))
            ],
          ),
        )));
  }
}
