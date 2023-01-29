import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static RouteManager instance = RouteManager();

  push({required Widget to, required BuildContext context}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => to),
    );
  }
}
