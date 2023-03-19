import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timetracker/Controller/DeviceUsageController.dart';
import 'package:timetracker/Services/Helpers/FontStyleHelper.dart';
import 'package:timetracker/Model/DashBoardCardModel.dart';
import 'package:timetracker/Screens/DashBoard/DeviceUsage/DeviceUsagePage.dart';
import 'package:timetracker/Screens/POC/ParallexDelegate.dart';
import 'package:timetracker/Services/RouteManager.dart';
import 'package:timetracker/Services/Theme/ColorConstant.dart';

class DashBoardCard extends StatelessWidget {
  // ScrollableState scroll;
  // String lottiePath;

  // DashBoardCard({required this.scroll, required this.lottiePath});

  DashboardCardModel cardData;

  DashBoardCard({required this.cardData});

  final GlobalKey _backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
        closedColor: darkBackground,
        openColor: Colors.transparent,
        closedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        openBuilder: (context, action) {
          return DeviceUsagePage(lottiePath: cardData.lottieFilePath);
        },
        closedBuilder: (context, action) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              children: [
                SizedBox(
                  height: 250,
                  child: Container(
                    height: 250,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.5),
                          blurRadius: 4.0,
                          spreadRadius: 0.0,
                          offset: Offset(
                            1.0, // Move to right 10  horizontally
                            1.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Stack(
                        alignment: Alignment.center,
                        fit: StackFit.expand,
                        children: [
                          Opacity(
                              opacity: 0.8,
                              child: Hero(
                                tag: cardData.lottieFilePath,
                                child: Container(
                                  child: LottieBuilder.asset(
                                      key: _backgroundImageKey,
                                      cardData.lottieFilePath),
                                ),
                              )),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(child: Container()),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      cardData.cardTitle,
                                      style: FontStyleHelper.shared
                                          .getPopppinsMedium(
                                              cardData.titleColor, 25),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              if (cardData.shouldUpdate) ...[
                                Consumer<DeviceUsageController>(
                                    builder: (context, value, child) {
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            value.appUsage,
                                            style: FontStyleHelper.shared
                                                .getPopppinsBold(
                                                    cardData.descColor, 18),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ] else ...[
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          cardData.cardDesc,
                                          style: FontStyleHelper.shared
                                              .getPopppinsBold(
                                                  cardData.descColor, 18),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ClipOval(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(stops: [
                                        0.3,
                                        1.0
                                      ], colors: [
                                        Colors.amber,
                                        Colors.yellowAccent
                                      ])),
                                      width: 40,
                                      height: 40,
                                      child: Icon(
                                        Icons.arrow_right_alt,
                                        color: whiteText,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Shimmer.fromColors(
                    baseColor: Colors.transparent,
                    highlightColor: Colors.white.withOpacity(0.2),
                    period: Duration(seconds: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: Colors.black,
                        height: 250,
                      ),
                    )),
              ],
            ),
          );
        });
  }
}
