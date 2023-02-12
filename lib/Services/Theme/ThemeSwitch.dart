import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/Services/Theme/ThemeManager.dart';

Widget themeSwitch(BuildContext context) {
  final themeprovider = Provider.of<ThemeProvider>(context);
  return Switch.adaptive(
      value: themeprovider.isDarkMode,
      onChanged: ((value) {
        Provider.of<ThemeProvider>(context, listen: false)
            .changeAppTheme(value);
      }));
}
