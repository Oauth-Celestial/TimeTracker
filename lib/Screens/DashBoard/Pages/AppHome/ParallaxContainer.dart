import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:timetracker/Model/InstalledAppModel.dart';
import 'package:timetracker/Screens/DashBoard/Pages/AppDetail/AppDetail.dart';
import 'package:timetracker/Screens/DashBoard/Pages/AppHome/HomePage.dart';
import 'package:timetracker/Services/DateHelper.dart';
import 'package:timetracker/Services/RouteManager.dart';

class ParallaxContainer extends StatefulWidget {
  final Widget image;
  final double offset;
  final double i;
  final String text;
  final InstalledAppData appData;

  ParallaxContainer(
      {required this.image,
      required this.offset,
      required this.i,
      required this.text,
      required this.appData});

  @override
  _ParallaxContainerState createState() => _ParallaxContainerState();
}

class _ParallaxContainerState extends State<ParallaxContainer> {
  //THIS VARIABLE ARE USED TO AFFECT THE SIZE OF THE CARD USING ANIMATED PADDING WIDGET
  double bottomPad = 40.0;
  double topPad = 0.0;
  double horiPad = 25.0;

  @override
  Widget build(BuildContext context) {
    String appUsed = DateHelper.instance.getFormattedAppUsage(widget.appData);
    return Scaffold(
      body: GestureDetector(
        onTapDown: (value) {
          setState(() {
            bottomPad = 50.0;
            topPad = 10.0;
            horiPad = 35.0;
          });
        },
        onTapUp: (value) {
          setState(() {
            setState(() {
              bottomPad = 40.0;
              topPad = 0.0;
              horiPad = 25.0;
            });
          });
        },
        onTap: () {
          RouteManager.instance
              .push(to: AppDetailPage(app: widget.appData), context: context);
        },

        // THIS WIDGET HELPS US TO MAKE THE CARD TOUCH REACTIVE...
        child: AnimatedPadding(
          duration: Duration(milliseconds: 150),
          padding: EdgeInsets.only(
            left: horiPad,
            right: horiPad,
            bottom: bottomPad,
            top: topPad,
          ),
          child: Stack(
            children: [
              Card(
                color: Colors.black,
                //elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: double.infinity,
                          //THIS DECORATION WILL HELP US TO GIVE THE NICE GRADIENT ABOVE THE IMAGE...
                          // foregroundDecoration: BoxDecoration(
                          //   gradient: LinearGradient(
                          //     begin: Alignment.topCenter,
                          //     end: Alignment.bottomCenter,
                          //     colors: [
                          //       // Color(0x00000000),
                          //       // Color(0x00000000),
                          //       // Color(0xff000000),
                          //     ],
                          //   ),
                          // ),

                          child: Hero(
                            tag: widget.appData.packageName,
                            child: Container(
                                child: widget.image,
                                alignment: Alignment(0.0,
                                    -((widget.offset.abs() + 0.4) - widget.i))),
                          ),
                          // child: Image.asset(
                          //   'assets/${widget.index}.jpg',
                          //   fit: BoxFit.fitWidth,
                          //   alignment: Alignment(
                          //       0.0, -((widget.offset.abs() + 0.4) - widget.i)),
                          // ),
                        ),
                      ),

                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 30, 30),
                          child: Container(
                              height: 35.0,
                              child: Icon(
                                Icons.pie_chart,
                                color: Colors.amber,
                                size: 30,
                              )),
                        ),
                      ),

                      //THIS IS FOR THE TEXT ABOVE THE IMAGE...
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: EdgeInsets.only(left: 35.0),
                          height: 140.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Hero(
                                tag: widget.text,
                                child: Material(
                                  color: Colors.transparent,
                                  child: Text(
                                    widget.text,
                                    style: TextStyle(
                                      color: Colors.amber,
                                      fontSize: 28.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Today's Usage",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  appUsed,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'SlimPlay',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn().slideX();
  }
}
