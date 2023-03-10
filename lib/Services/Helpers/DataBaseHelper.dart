import 'dart:ffi';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:timetracker/Model/InstalledAppModel.dart';
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

  Future<List<Map>> getAllRecords(String date) async {
    Database db = await getdataBase();
    List<InstalledAppData> appData = [];
    List<Map>? records = await db.rawQuery(
        "select * from DailyUsage where usedOn = ? ORDER BY  CAST (appDuration as int) DESC ",
        [date]);
    for (Map<dynamic, dynamic> record in records) {
      print(record["appPackageName"]);
    }
    return records;
  }

  getDeviceUsage(String date) async {
    // SELECT SUM(CAST(appDuration as int ))FROM DailyUsage WHERE usedOn = "2023/03/02"
    String deviceUsage = "";

    Database db = await getdataBase();
    String sql =
        """SELECT SUM(CAST(appDuration as int)) as deviceUsage  FROM DailyUsage WHERE usedOn = ?""";
    List<Map>? records = await db.rawQuery(sql, [date]);
    print("App Data is   $records");
    for (Map<dynamic, dynamic> record in records) {
      deviceUsage = DateHelper.instance
          .getFormattedTimeFromSeconds(record["deviceUsage"] as int);
    }
    return deviceUsage;
  }

  saveAllDataToDb(
    List<InstalledAppData> saveApps,
    String fileName,
  ) async {
    var now = new DateTime.now().toString();
    // var formatter = new DateFormat('dd-MM-yyyy');
    // String formattedTime = DateFormat('kk:mm:a').format(now);
    // String formattedDate = formatter.format(now);
    print("apps saved length = ${saveApps.length}");
    // if (now.hour >= 22 && now.minute > 45) {
    for (InstalledAppData app in saveApps) {
      print(database);
      int? data = await database?.rawInsert(
          'INSERT INTO appUsageTable(appName,Duration , Date) VALUES(?, ?, ?)',
          [app.packageName, app.appDuration.inSeconds, now]);
      print("data ${data}");
    }

    // database?.close();
    // }

    // int? data = await database?.rawInsert(
    //     'INSERT INTO appUsageTable(appName,Duration , Date) VALUES(?, ?, ?)',
    //     ["test", 10, "27 Feb 2023"]);
    // print(data);
  }
}
