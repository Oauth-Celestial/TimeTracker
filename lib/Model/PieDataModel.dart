import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class PieChartDataModel {
  String? title;
  double? value;
  Uint8List? bytes;

  PieChartDataModel({required this.title, required value, required this.bytes});
}
