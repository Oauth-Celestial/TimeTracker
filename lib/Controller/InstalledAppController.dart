import 'package:device_apps/device_apps.dart';
import 'package:flutter/foundation.dart';

class InstalledAppController with ChangeNotifier {
  List<Application> installedApps = [];
  bool hasLoaded = false;
  getAllApps() async {
    installedApps =
        await DeviceApps.getInstalledApplications(includeAppIcons: true);
    hasLoaded = true;
    notifyListeners();
  }
}
