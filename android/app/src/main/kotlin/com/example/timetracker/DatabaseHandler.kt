package com.example.timetracker

import android.content.ContentValues
import android.database.Cursor
import android.database.sqlite.SQLiteDatabase
import android.util.Log
import com.example.timetracker.Helpers.DateHelper
import com.example.timetracker.Models.AppInfoModel

class DatabaseHandler() {

companion object{
    var instance:DatabaseHandler = DatabaseHandler()
}
    var db:SQLiteDatabase? = null
    var dataBasePath:String? = null
    var dailyUsageTable:String = "DailyUsage"

    fun openDataBase(dbPath:String){
        if (db == null){
            db = SQLiteDatabase.openDatabase(dbPath,null,SQLiteDatabase.OPEN_READWRITE)
            Log.e("db","$db")
        }
    }


    fun getAppDuration(appPackageName:String,appName:String):Int {
        openDataBase(dataBasePath as String)
        var appUsedFor = 0
        var todayDate:String = DateHelper.instance.getTodaysDate()
        Log.e("Todays Date" ," Date for $appPackageName :-  $todayDate")
        val sqlQuery = "SELECT * FROM $dailyUsageTable WHERE appPackageName = ? AND usedOn = ?"
        val c: Cursor = db!!.rawQuery(sqlQuery, arrayOf<String>(appPackageName, todayDate))
        if (c.count == 1){
            var appUsage = ""
            while(c.moveToNext()){
                appUsage = c.getString(3)

            }
           appUsedFor = appUsage.toInt()

        }
        else{
            appUsedFor = 0
            val sql = "INSERT into DailyUsage (appName,appDuration,appPackageName,usedOn) VALUES(\"$appName\",\"0\",\"$appPackageName\",\"$todayDate\")";

            //val sql = "INSERT into DailyUsage (appName,appDuration,appPackageName,usedOn) VALUES($appdata,\"0\",\"$appPackageName\",\"$todayDate\")"
          Log.e("Insert Sql","$sql")

            db!!.execSQL(sql)




        }
        c.close()
            return appUsedFor
    }



    fun addOrUpdateAppDuration(appInfo:AppInfoModel){
        openDataBase(dataBasePath as String)
        if(db != null){
            var todayDate:String = DateHelper.instance.getTodaysDate()
            val appduration = appInfo.timeUsedFor.getQuoted()
            val packageName = appInfo.appPackageName.getQuoted()
            val dateFor = todayDate.getQuoted()
            val updateSql:String = "Update $dailyUsageTable SET appDuration = $appduration  WHERE appPackageName = $packageName AND usedOn = $dateFor "
//        val sqlString = "IF EXISTS(SELECT * FROM $dailyUsageTable WHERE appPackageName = ${appInfo.appPackageName} AND usedOn = ${todayDate})" + "THEN" +
//                "UPDATE $dailyUsageTable SET appDuration  = ${appInfo.timeUsedFor}  WHERE appPackageName = ${appInfo.appPackageName} AND usedOn = ${todayDate})" +
//                "ELSE" +
//                "INSERT INTO $dailyUsageTable (appName, appPackageName, appDuration, usedOn) VALUES(${appInfo.appname},${appInfo.appPackageName},${appInfo.timeUsedFor},${todayDate})"
            db!!.execSQL(updateSql)
        }
        Log.e("Updated data", "${appInfo.timeUsedFor}")


    }

    fun clearTableData(tableName:String){

        openDataBase(dataBasePath as String)
        if(db != null){
            db!!.execSQL("Delete from $tableName")
        }
    }

    fun getAllApps(){
        openDataBase(dataBasePath as String)
        if (db != null){

            val c: Cursor = db!!.rawQuery("select * from $dailyUsageTable ", null)
            Log.e("Data in DailyUsage","${c.count}")
//            while(c.moveToNext()){
//               Log.e("dbdata","${c.getString(1)}")
//            }
        }
    }


    fun String.getQuoted() = "\"${this}\""




}