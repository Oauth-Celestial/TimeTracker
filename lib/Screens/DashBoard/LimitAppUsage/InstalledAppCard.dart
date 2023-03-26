import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timetracker/Screens/DashBoard/LimitAppUsage/AppBottomSheet.dart';
import 'package:timetracker/Services/Helpers/AppHelper..dart';
import 'package:timetracker/Services/Helpers/FontStyleHelper.dart';
import 'package:timetracker/Services/Theme/ColorConstant.dart';

class InstalledAppCard extends StatelessWidget {
  Application app;
  InstalledAppCard({required this.app});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 5),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(15)),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 12,
              ),
              FutureBuilder<Widget>(
                  future:
                      AppHelper.instance.getAppIconFromPackage(app.packageName),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: ClipOval(
                            child: Container(
                          child: Container(
                              width: 40, height: 40, child: snapshot.data),
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
                app.appName,
                style: FontStyleHelper.shared.getPopppinsBold(whiteText, 16),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: ((context) {
                          return Theme(
                              data: Theme.of(context).copyWith(
                                canvasColor: Colors.transparent,
                              ),
                              child: buildSheet());
                        }));
                  },
                  child: Container(
                    width: 100,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: yellow, borderRadius: BorderRadius.circular(60)),
                    child: Text(
                      "Set Limit",
                      style: FontStyleHelper.shared
                          .getPopppinsBold(Colors.black, 15),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
