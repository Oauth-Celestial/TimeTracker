import 'package:animations/animations.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timetracker/Model/AppModel.dart';
import 'package:timetracker/Screens/DashBoard/DeviceUsage/AppDetailPage.dart';
import 'package:timetracker/Services/Helpers/AppHelper..dart';
import 'package:timetracker/Services/Helpers/FontStyleHelper.dart';

import '../../../../Services/Theme/ColorConstant.dart';

class LimitAppUsageCard extends StatelessWidget {
  Application appdata;
  LimitAppUsageCard({required this.appdata});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openColor: darkBackground,
      closedColor: darkBackground,
      closedBuilder: (context, action) {
        return ClipRRect(
          child: Stack(
            fit: StackFit.loose,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadowColor: Colors.grey,
                child: Container(
                  height: 80,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      FutureBuilder<Widget>(
                          future: AppHelper.instance
                              .getAppIconFromPackage(appdata.packageName),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(top: 18, left: 5),
                                child: ClipOval(
                                    child: Container(
                                  width: 40,
                                  height: 40,
                                  child: snapshot.data,
                                )),
                              );
                            } else {
                              return ClipOval(
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.black,
                                      highlightColor: Colors.grey,
                                      child: Image.asset(
                                        "assets/luffy.jpg",
                                        fit: BoxFit.fill,
                                      ),
                                    )),
                              );
                            }
                          }),
                      SizedBox(
                        width: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(appdata.appName,
                                textAlign: TextAlign.center,
                                style: FontStyleHelper.shared
                                    .getPopppinsBold(Colors.yellowAccent, 16)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "",
                              textAlign: TextAlign.center,
                              style: FontStyleHelper.shared
                                  .getPopppinsMedium(whiteText, 14),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.lock_open_rounded,
                                size: 18,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    boxShadow: [],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      openBuilder: ((context, action) {
        return Container();
      }),
    );
  }
}
