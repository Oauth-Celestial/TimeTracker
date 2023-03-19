import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class EnableFocusModeController with ChangeNotifier {
  bool enableFocusMode = false;

  addAppToFocusMode() {
    enableFocusMode = !enableFocusMode;
    notifyListeners();
  }
}
