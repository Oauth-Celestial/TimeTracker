import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/Controller/InstalledAppController.dart';
import 'package:timetracker/Model/InstalledAppModel.dart';
import 'package:timetracker/Services/Theme/ColorConstant.dart';
import 'ParallaxContainer.dart';

class ParallaxPageView extends StatefulWidget {
  PageController controller;
  double offset;
  ParallaxPageView({
    required this.controller,
    required this.offset,
  });

  @override
  _ParallaxPageViewState createState() => _ParallaxPageViewState();
}

class _ParallaxPageViewState extends State<ParallaxPageView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InstalledAppController>(builder: (context, value, child) {
      List<InstalledAppData> installedApps = value.userInstalledApps;
      return Scaffold(
        appBar: AppBar(
          title: Text("All Apps"),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: PageView(
                  physics: BouncingScrollPhysics(),
                  pageSnapping: false,
                  padEnds: false,
                  scrollDirection: Axis.vertical,
                  controller: widget.controller,
                  children: [
                    for (int i = 0; i < installedApps.length; i++) ...[
                      ParallaxContainer(
                          image: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                scale: 1.0,
                                alignment: Alignment(0.0, -0.35),
                                image: MemoryImage(
                                  installedApps[i].bytes ?? Uint8List(10),
                                ),
                              ),
                            ),
                          ),
                          offset: widget.offset,
                          i: i.toDouble(),
                          appData: installedApps[i],
                          text: installedApps[i].appname)
                    ],
                    if (installedApps.length == 0 && value.hasLoaded) ...[
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "No Activity Today",
                          style: TextStyle(color: whiteText),
                        ),
                      )
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
