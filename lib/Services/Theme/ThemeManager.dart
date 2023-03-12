import 'package:flutter/material.dart';
import 'package:timetracker/Services/Theme/ColorConstant.dart';

class MyTheme {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade900,
      colorScheme: ColorScheme.dark(),
      primaryColor: darkBackground,
      backgroundColor: Colors.black);

  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: whiteText,
      colorScheme: ColorScheme.light(),
      backgroundColor: whiteText,
      primaryColor: whiteText);
}

class ThemeProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void changeAppTheme(bool isDark) {
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
