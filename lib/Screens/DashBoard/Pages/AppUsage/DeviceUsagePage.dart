import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timetracker/Controller/DeviceUsageController.dart';
import 'package:timetracker/Services/Helpers/AppHelper..dart';
import 'package:timetracker/Services/Helpers/FontStyleHelper.dart';
import 'package:timetracker/Services/Theme/ColorConstant.dart';

class DeviceUsagePage extends StatefulWidget {
  String lottiePath;
  DeviceUsagePage({required this.lottiePath});

  @override
  State<DeviceUsagePage> createState() => _DeviceUsagePage();
}

class _DeviceUsagePage extends State<DeviceUsagePage> {
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
                    child: Hero(
                      tag: widget.lottiePath,
                      child: Container(
                        child: LottieBuilder.asset(widget.lottiePath),
                      ),
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
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Top Used App ",
                style:
                    FontStyleHelper.shared.getPopppinsBold(Colors.yellow, 20),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: AppUsageCard(
                isForTopApp: true,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "All Apps",
                style:
                    FontStyleHelper.shared.getPopppinsBold(Colors.yellow, 20),
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
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: AppUsageCard(
                        isForTopApp: false,
                      ),
                    );
                  })),
            )
          ],
        ),
      )),
    );
  }
}

class AppUsageCard extends StatelessWidget {
  bool isForTopApp;
  AppUsageCard({required this.isForTopApp});

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
                      future: AppHelper.instance.getAppIconFromPackage(),
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
                                child: Image.asset(
                                  "assets/luffy.jpg",
                                  fit: BoxFit.fill,
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
                        Text('Clash Of Clans',
                            textAlign: TextAlign.center,
                            style: FontStyleHelper.shared
                                .getPopppinsBold(whiteText, 15)),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          '1 hour 10 min ',
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
