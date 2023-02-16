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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Container(
                  width: 80,
                  height: 80,
                  color: Colors.black,
                  child: widget.app.appIcon,
                ),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: widget.app.appname,
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    widget.app.appname,
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
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
