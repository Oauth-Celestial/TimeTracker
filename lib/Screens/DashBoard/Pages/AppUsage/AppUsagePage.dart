import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timetracker/Services/Helpers/FontStyleHelper.dart';
import 'package:timetracker/Services/Theme/ColorConstant.dart';

class AppUsagePage extends StatefulWidget {
  String lottiePath;
  AppUsagePage({required this.lottiePath});

  @override
  State<AppUsagePage> createState() => _AppUsagePageState();
}

class _AppUsagePageState extends State<AppUsagePage> {
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
                          Text(
                            "1 hour 10 min",
                            style: FontStyleHelper.shared
                                .getPopppinsRegular(whiteText, 20),
                          ),
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
              height: 10,
            ),
            AppUsageCard()
          ],
        ),
      )),
    );
  }
}

class AppUsageCard extends StatelessWidget {
  const AppUsageCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ClipRRect(
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
                    ClipOval(
                      child: Container(
                          width: 50,
                          height: 50,
                          child: Image.asset(
                            "assets/luffy.jpg",
                            fit: BoxFit.fill,
                          )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Usage Permission',
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
          ],
        ),
      ),
    );
  }
}
