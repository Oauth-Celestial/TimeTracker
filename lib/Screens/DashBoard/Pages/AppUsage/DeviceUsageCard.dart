import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timetracker/Model/AppModel.dart';
import 'package:timetracker/Services/Helpers/AppHelper..dart';
import 'package:timetracker/Services/Helpers/FontStyleHelper.dart';

import '../../../../Services/Theme/ColorConstant.dart';

class DeviceUsageCard extends StatelessWidget {
  bool isForTopApp;
  AppModelData appdata;
  DeviceUsageCard({required this.isForTopApp, required this.appdata});

  @override
  Widget build(BuildContext context) {
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
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  FutureBuilder<Widget>(
                      future: AppHelper.instance
                          .getAppIconFromPackage(appdata.appPackageName),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ClipOval(
                              child: Container(
                            width: 50,
                            height: 50,
                            child: snapshot.data,
                          ));
                        } else {
                          return ClipOval(
                            child: Container(
                                width: 50,
                                height: 50,
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
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(appdata.appName,
                            textAlign: TextAlign.center,
                            style: FontStyleHelper.shared
                                .getPopppinsBold(whiteText, 15)),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          appdata.appDuration,
                          textAlign: TextAlign.center,
                          style: FontStyleHelper.shared
                              .getPopppinsMedium(whiteText, 13),
                        ),
                      ],
                    ),
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
          if (isForTopApp) ...[
            Shimmer.fromColors(
                baseColor: Colors.transparent,
                highlightColor: Colors.white.withOpacity(0.3),
                period: Duration(seconds: 3),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.black,
                    height: 80,
                  ),
                )),
          ]
        ],
      ),
    );
  }
}
