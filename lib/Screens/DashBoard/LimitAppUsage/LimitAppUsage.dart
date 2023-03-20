import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timetracker/Controller/LimitAppUsageController.dart';
import 'package:timetracker/Screens/DashBoard/DeviceUsage/Cards/DetailPageHeader.dart';
import 'package:timetracker/Services/Helpers/AppHelper..dart';
import 'package:timetracker/Services/Helpers/FontStyleHelper.dart';
import 'package:timetracker/Services/Theme/ColorConstant.dart';

class LimitAppUsage extends StatelessWidget {
  const LimitAppUsage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<LimitAppUsageController>(context, listen: false).getAllApps();
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailPageHeader(
                  title: "Limit App Usage",
                  description:
                      "Maximizing Productivity: Limiting App Usage to Stay Focused",
                  lottiePath: "assets/Meditate.json"),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Installed Apps",
                  style:
                      FontStyleHelper.shared.getPopppinsBold(yellowAccent, 24),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(child: Consumer<LimitAppUsageController>(
                  builder: (context, controller, child) {
                if (controller.hasLoadedData) {
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 2.0 / 1.8),
                      itemCount: controller.installedApps.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 15, top: 5),
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 12,
                                  ),
                                  FutureBuilder<Widget>(
                                      future: AppHelper.instance
                                          .getAppIconFromPackage(controller
                                              .installedApps[index]
                                              .packageName),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: ClipOval(
                                                child: Container(
                                              child: Container(
                                                  width: 40,
                                                  height: 40,
                                                  child: snapshot.data),
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
                                    height: 15,
                                  ),
                                  Text(
                                    controller.installedApps[index].appName,
                                    style: FontStyleHelper.shared
                                        .getPopppinsBold(whiteText, 16),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 100,
                                      height: 30,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: yellow,
                                          borderRadius:
                                              BorderRadius.circular(60)),
                                      child: Text(
                                        "Limit",
                                        style: FontStyleHelper.shared
                                            .getPopppinsBold(Colors.black, 15),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }));
                } else {
                  return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      color: amber,
                    ),
                  );
                }
              })),
            ],
          ),
        ),
      ),
    );
  }
}
