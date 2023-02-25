import 'package:flutter/cupertino.dart';

class OnBoardingController with ChangeNotifier {
  int currentPage = 0;

  changeOnBoardingPage(int index) {
    currentPage = index;
    notifyListeners();
  }
}
