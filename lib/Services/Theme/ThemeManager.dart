import 'package:flutter/material.dart';

class MyTheme {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade900,
      colorScheme: ColorScheme.dark(),
      primaryColor: Colors.white,
      backgroundColor: Colors.black);

  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(),
      backgroundColor: Colors.white,
      primaryColor: Colors.white);
}

class ThemeProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void changeAppTheme(bool isDark) {
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
