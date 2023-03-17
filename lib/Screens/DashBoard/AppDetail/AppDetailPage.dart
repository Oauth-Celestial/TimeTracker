import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timetracker/Model/AppModel.dart';
import 'package:timetracker/Services/Helpers/AppHelper..dart';
import 'package:timetracker/Services/Helpers/FontStyleHelper.dart';
import 'package:timetracker/Services/Theme/ColorConstant.dart';

class AppDetailPage extends StatefulWidget {
  AppModelData appdata;

  AppDetailPage({required this.appdata});

  @override
  State<AppDetailPage> createState() => _AppDetailPageState();
}

class _AppDetailPageState extends State<AppDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        title: Text("App Detail"),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 2,
                shadowColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    height: 170,
                    color: Colors.black,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            FutureBuilder<Widget>(
                                future: AppHelper.instance
                                    .getAppIconFromPackage(
                                        widget.appdata.appPackageName),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 5),
                                      child: ClipOval(
                                          child: Container(
                                        child: Container(
                                            width: 50,
                                            height: 50,
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
                              width: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.appdata.appName,
                                    style: FontStyleHelper.shared
                                        .getPopppinsBold(whiteText, 18),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Last Used On :-${widget.appdata.lastUsedOn}",
                                    style: FontStyleHelper.shared
                                        .getPopppinsBold(yellowAccent, 14),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Expanded(child: Container()),
                        Container(
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 150,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(color: amber),
                                    borderRadius: BorderRadius.circular(25)),
                                child: Text(
                                  "Uninstall",
                                  style: FontStyleHelper.shared
                                      .getPopppinsRegular(amber, 16),
                                ),
                              ),
                              Container(
                                width: 150,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: amber,
                                    borderRadius: BorderRadius.circular(25)),
                                child: Text(
                                  "Open",
                                  style: FontStyleHelper.shared
                                      .getPopppinsBold(whiteText, 15),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
