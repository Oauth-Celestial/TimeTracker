import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/Services/Theme/ThemeManager.dart';
import 'package:timetracker/Services/Theme/ThemeSwitch.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode
          ? Colors.black
          : Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              child: Text("Settings"),
            ),
            themeSwitch(context),
          ],
        ),
      ),
    );
  }
}
