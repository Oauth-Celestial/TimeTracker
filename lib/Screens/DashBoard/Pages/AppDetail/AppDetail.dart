import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/Model/InstalledAppModel.dart';
import 'package:timetracker/Services/Theme/ColorConstant.dart';
import 'package:timetracker/Services/Theme/ThemeManager.dart';

class AppDetailPage extends StatefulWidget {
  InstalledAppData app;
  AppDetailPage({required this.app});

  @override
  State<AppDetailPage> createState() => _AppDetailPageState();
}

class _AppDetailPageState extends State<AppDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "App Detail",
        ),
      ),
      backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode
          ? darkBackground
          : Colors.white,
      body: SafeArea(
          child: ListView(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
              height: 200,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Hero(
                        tag: widget.app.packageName,
                        child: ClipOval(
                          child: Image.memory(
                            widget.app.bytes!,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Hero(
                        tag: widget.app.appname,
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            child: Text(
                              widget.app.appname,
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.amber,
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Material(
          //       color: Colors.transparent,
          //       child: Text(
          //         widget.app.appname,
          //         style: TextStyle(
          //             fontSize: 23,
          //             fontWeight: FontWeight.bold,
          //             color: Colors.white),
          //       ),
          //     ),
          //   ],
          // ),

          Container(
            height: 100,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Icon(
                            Icons.delete,
                            color: Colors.amber,
                            size: 30,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Uninstall",
                            style: TextStyle(color: Colors.amber),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Icon(
                            Icons.pie_chart,
                            color: Colors.amber,
                            size: 30,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Report",
                            style: TextStyle(color: Colors.amber),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ).animate().fadeIn(delay: Duration(milliseconds: 300)),
            ),
          )
        ],
      )),
    );
  }
}
