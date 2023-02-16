import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/Model/InstalledAppModel.dart';
import 'package:timetracker/Screens/DashBoard/Pages/AppDetail/AppDetail.dart';
import 'package:timetracker/Services/DateHelper.dart';
import 'package:timetracker/Services/RouteManager.dart';
import 'package:timetracker/Services/Theme/ThemeManager.dart';

class TopAppCard extends StatelessWidget {
  InstalledAppData app;
  TopAppCard({required this.app});

  @override
  Widget build(BuildContext context) {
    String appUsed = DateHelper.instance.getFormattedAppUsage(app);
    return InkWell(
      onTap: () {
        RouteManager.instance
            .push(to: AppDetailPage(app: app), context: context);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 20,
            height: 130,
            color: Colors.white,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8),
                        child: ClipOval(
                          child: Container(
                            width: 38,
                            height: 38,
                            color: Colors.black,
                            // child: ClipOval(
                            //   child: app.appIcon,
                            // ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 15),
                            child: Container(
                                alignment: Alignment.centerLeft,
                                color: Colors.transparent,
                                width: 150,
                                height: 30,
                                child: Text(
                                  app.appname,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0, left: 15),
                            child: Container(
                                alignment: Alignment.centerLeft,
                                color: Colors.transparent,
                                width: 150,
                                height: 15,
                                child: Text(
                                  "Last Used :- 1 hour ago",
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: ClipOval(
                              child: Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                    color: Provider.of<ThemeProvider>(context)
                                            .isDarkMode
                                        ? Colors.black
                                        : Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            10.0) //                 <--- border radius here
                                        ),
                                    border: Border.all(
                                        color: Colors.blueGrey, width: 2.5)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: Row(
                        children: [
                          Text("Time Spend :-${appUsed}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 10),
                      child: Row(
                        children: [
                          Text("App Usage",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Text("3%"),
                          Icon(
                            Icons.arrow_upward,
                            color: Colors.greenAccent,
                          ),
                          Text(
                            "then Yesterday",
                            style: TextStyle(
                              color: Colors.greenAccent,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ).animate().fade(),
    );
  }
}
