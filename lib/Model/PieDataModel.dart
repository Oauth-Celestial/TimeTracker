import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class PieChartDataModel {
  String? title;
  double? timeSpent;
  Uint8List? bytes;

  PieChartDataModel(
      {required this.title, required this.timeSpent, required this.bytes});
}
