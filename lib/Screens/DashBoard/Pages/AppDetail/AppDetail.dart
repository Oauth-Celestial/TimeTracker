import 'package:flutter/material.dart';
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
          )
        ],
      )),
    );
  }
}
