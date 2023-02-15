import 'package:flutter/material.dart';
import 'package:timetracker/Model/InstalledAppModel.dart';
import 'package:timetracker/Screens/DashBoard/Pages/AppDetail/AppDetail.dart';
import 'package:timetracker/Services/DateHelper.dart';
import 'package:timetracker/Services/RouteManager.dart';

class InstalledAppCard extends StatelessWidget {
  int index;
  InstalledAppData app;
  InstalledAppCard({required this.index, required this.app});

  String appUsed = "";

  @override
  Widget build(BuildContext context) {
    appUsed = DateHelper.instance.getFormattedAppUsage(app);
    return InkWell(
      onTap: () {
        RouteManager.instance
            .push(to: AppDetailPage(app: app), context: context);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 8,
              ),
              ClipOval(
                child: Container(
                  width: 45,
                  height: 45,
                  color: Colors.black,
                  child: app.appIcon,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                app.appname,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                appUsed,
                style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
