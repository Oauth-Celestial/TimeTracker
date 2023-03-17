import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timetracker/Controller/DeviceUsageController.dart';
import 'package:timetracker/Model/AppModel.dart';
import 'package:timetracker/Screens/DashBoard/Pages/AppUsage/DeviceUsageCard.dart';
import 'package:timetracker/Services/Helpers/AppHelper..dart';
import 'package:timetracker/Services/Helpers/DataBaseHelper.dart';
import 'package:timetracker/Services/Helpers/DateHelper.dart';
import 'package:timetracker/Services/Helpers/FontStyleHelper.dart';
import 'package:timetracker/Services/Theme/ColorConstant.dart';

class DeviceUsagePage extends StatefulWidget {
  String lottiePath;
  DeviceUsagePage({required this.lottiePath});

  @override
  State<DeviceUsagePage> createState() => _DeviceUsagePage();
}

class _DeviceUsagePage extends State<DeviceUsagePage> {
  late Future<List<AppModelData>> data;
  late Future<int> unlocks;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String todaysDate = DateHelper.instance.getTodaysFormattedDate();
    data = DataBaseHelper.instance.getAllRecords(todaysDate);
    unlocks = DataBaseHelper.instance.getTotalUnlocks(todaysDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: darkBackground,
      body: SafeArea(
          child: Container(
        child: ListView(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: 0.8,
                  child: Container(
                    height: 200,
                    child: Container(
                      child: LottieBuilder.asset(widget.lottiePath),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.5),
                  ])),
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Expanded(child: Container()),
                          Text(
                            "Today's Device Usage",
                            style: FontStyleHelper.shared
                                .getPopppinsBold(whiteText, 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
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
                                          .getPopppinsBold(whiteText, 18),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                          SizedBox(
                            height: 30,
                          )
                        ])
                        .animate()
                        .moveX(
                            delay: Duration(milliseconds: 500),
                            begin: -100,
                            end: 0)
                        .fadeIn(delay: Duration(milliseconds: 400)),
                  ),
                ).animate().fadeIn(delay: Duration(milliseconds: 300))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<int>(
                  future: unlocks,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        child: Column(
                          children: [
                            Text(
                              "${snapshot.data ?? 0}",
                              style: FontStyleHelper.shared
                                  .getPopppinsBold(Colors.yellow, 25),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Unlocks",
                              style: FontStyleHelper.shared
                                  .getPopppinsMedium(Colors.yellow, 18),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        height: 100,
                        color: Colors.transparent,
                        child: CircularProgressIndicator(
                          color: amber,
                        ),
                      );
                    }
                  }),
            ),
            FutureBuilder<List<AppModelData>>(
                future: data,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Top Used App ",
                            style: FontStyleHelper.shared
                                .getPopppinsBold(Colors.yellow, 20),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: DeviceUsageCard(
                            isForTopApp: true,
                            appdata: snapshot.data![0],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "All Apps",
                            style: FontStyleHelper.shared
                                .getPopppinsBold(Colors.yellow, 20),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: ((context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: DeviceUsageCard(
                                    isForTopApp: false,
                                    appdata: snapshot.data![index],
                                  ),
                                );
                              })),
                        )
                      ],
                    );
                  } else {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              "Top Used App ",
                              style: FontStyleHelper.shared
                                  .getPopppinsBold(Colors.yellow, 20),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container()),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              "All Apps",
                              style: FontStyleHelper.shared
                                  .getPopppinsBold(Colors.yellow, 20),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 10,
                                itemBuilder: ((context, index) {
                                  return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 10, 5),
                                      child: Container(
                                        color: Colors.white,
                                      ));
                                })),
                          )
                        ]);
                  }
                })
          ],
        ),
      )),
    );
  }
}
