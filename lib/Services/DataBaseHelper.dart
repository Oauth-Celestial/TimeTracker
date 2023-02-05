import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DataBaseHelper {
  static DataBaseHelper instance = DataBaseHelper();
  Database? database;

  Future initDb(String fileName) async {
    String baseDbPath = await getDatabasesPath();
    String dataBasePath = path.join(baseDbPath, fileName);
    bool isDatabasePresent = await databaseExists(dataBasePath);

    if (isDatabasePresent) {
      print("dataBase present already");
      database = await openDatabase(dataBasePath);
    } else {
      try {
        await Directory(path.dirname(dataBasePath)).create(recursive: true);
      } catch (e) {}
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

  saveAllDataToDb() async {
    // int? data = await database?.rawInsert(
    //     'INSERT INTO appUsageTable(appName,Duration , Date) VALUES(?, ?, ?)',
    //     ["test", 10, "27 Feb 2023"]);
    // print(data);
  }
}
