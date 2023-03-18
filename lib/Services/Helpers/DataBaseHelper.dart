import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:timetracker/Model/AppModel.dart';
import 'package:timetracker/Services/Helpers/DateHelper.dart';

class DataBaseHelper {
  static DataBaseHelper instance = DataBaseHelper();
  Database? database;
  String dataBasePath = "";

  Future<Database> getdataBase() async {
    String baseDbPath = await getDatabasesPath();
    dataBasePath = path.join(baseDbPath, "tracker.db");
    bool isDatabasePresent = await databaseExists(dataBasePath);
    if (!isDatabasePresent) {
      await initDb("tracker.db");
    }
    Database database = await openDatabase(dataBasePath);

    return database;
  }

  Future initDb(String fileName) async {
    String baseDbPath = await getDatabasesPath();
    dataBasePath = path.join(baseDbPath, fileName);
    bool isDatabasePresent = await databaseExists(dataBasePath);

    if (isDatabasePresent) {
      print("dataBase present already");
      database = await openDatabase(dataBasePath);
    } else {
      try {
        await Directory(path.dirname(dataBasePath)).create(recursive: true);
      } catch (e) {
        print(e);
      }
      ByteData data = await rootBundle.load(path.join("assets", fileName));
      List<int> bytes =
          data.buffer.asInt8List(data.offsetInBytes, data.lengthInBytes);
      await File(dataBasePath).writeAsBytes(bytes, flush: true);
      print("db copied at $dataBasePath");
    }
    database = await openDatabase(dataBasePath);
  }

  closeDataBase() async {
    await database?.close();
  }

  Future<int> getTotalUnlocks(String date) async {
    int deviceUnlocks = 0;

    Database db = await getdataBase();
    String sql =
        """SELECT SUM(CAST(launchCount as int)) as launchCount  FROM DailyUsage WHERE usedOn = ? AND appPackageName NOT LIKE '%launcher%'""";
    List<Map>? records = await db.rawQuery(sql, [date]);
    print("App Data is   $records");
    for (Map<dynamic, dynamic> record in records) {
      deviceUnlocks = record["launchCount"] as int;
    }
    return deviceUnlocks;
  }

  Future<List<AppModelData>> getAllRecords(String date) async {
    List<AppModelData> usedApps = [];
    Database db = await getdataBase();

    List<Map>? records = await db.rawQuery(
        "select * from DailyUsage where usedOn = ? AND appPackageName NOT LIKE '%launcher%'  ORDER BY  CAST (appDuration as int) DESC ",
        [date]);
    for (Map<dynamic, dynamic> record in records) {
      // print(record["appPackageName"]);
      usedApps.add(
        AppModelData(
            appName: record["appName"],
            appDuration: DateHelper.instance
                .getFormattedTimeFromSeconds(int.parse(record["appDuration"])),
            appPackageName: record["appPackageName"],
            launchCount: record["launchCount"],
            lastUsedOn: record["lastActive"]),
      );
    }
    return usedApps;
  }

  getDeviceUsage(String date) async {
    // SELECT SUM(CAST(appDuration as int ))FROM DailyUsage WHERE usedOn = "2023/03/02"
    String deviceUsage = "";

    Database db = await getdataBase();
    String sql =
        """SELECT SUM(CAST(appDuration as int)) as deviceUsage  FROM DailyUsage WHERE usedOn = ? AND appPackageName NOT LIKE '%launcher%'""";
    List<Map>? records = await db.rawQuery(sql, [date]);
    print("App Data is   $records");
    try {
      for (Map<dynamic, dynamic> record in records) {
        deviceUsage = DateHelper.instance
            .getFormattedTimeFromSeconds(record["deviceUsage"] as int);
      }
    } catch (e) {}
    return deviceUsage;
  }
}
