package com.example.timetracker

import android.content.ContentValues
import android.database.Cursor
import android.database.sqlite.SQLiteDatabase
import android.util.Log
import com.example.timetracker.Helpers.DateHelper
import com.example.timetracker.Models.AppInfoModel

class DatabaseHandler {

companion object{
    var instance:DatabaseHandler = DatabaseHandler()
}
    var db:SQLiteDatabase? = null
    var dataBasePath:String? = null
    var dailyUsageTable:String = "DailyUsage"
    var focusModeTable:String = "focusMode"
    var appsesionTable:String = "appSession"
    var dbPath = "/data/user/0/com.example.timetracker/databases/tracker.db"

    fun openDataBase(){

        if (db == null){
            db = SQLiteDatabase.openDatabase(dbPath,null,SQLiteDatabase.OPEN_READWRITE)
            Log.e("db","$db")
        }
    }

    fun getTotalDeviceUsage():Int {
        // SELECT SUM(CAST(appDuration as int ))FROM DailyUsage WHERE usedOn = "2023/03/02"
        var appUsage = "0"
        var sqlQuery = "SELECT SUM(CAST(appDuration as int )) FROM DailyUsage WHERE usedOn = ? AND appPackageName NOT LIKE '%launcher%' "
        var todayDate: String = DateHelper.instance.getTodaysDate()
        val c: Cursor = db!!.rawQuery(sqlQuery, arrayOf<String>(todayDate))

        if (c.count == 1) {

            while (c.moveToNext()) {
                appUsage = c.getString(0)

            }

        }
        return appUsage.toInt()
    }

    fun getAppLaunchCount(appPackageName:String,appName:String):Int{
        var appLaunch = 0
        var todayDate:String = DateHelper.instance.getTodaysDate()
        val sqlQuery = "SELECT * FROM $dailyUsageTable WHERE appPackageName = ? AND usedOn = ?"
        val c: Cursor = db!!.rawQuery(sqlQuery, arrayOf<String>(appPackageName, todayDate))
        if (c.count == 1){
            var appUsage = ""
            while(c.moveToNext()){
                appUsage = c.getString(6)

            }
            appLaunch = appUsage.toInt()

        }
        else{
            appLaunch = 0
        }
return  appLaunch

    }


    fun inFocusMode(appPackageName: String) : Boolean{
        openDataBase()
        val sqlQuery = "SELECT * FROM $focusModeTable WHERE packageName = ?"
        val c: Cursor = db!!.rawQuery(sqlQuery, arrayOf<String>(appPackageName))
        return c.count > 0
    }

    fun getFocusModeDurationFor(appPackageName: String) : Int{
        openDataBase()
        var appLimitedFor = -1
        val sqlQuery = "SELECT * FROM $focusModeTable WHERE packageName = ?"
        val c: Cursor = db!!.rawQuery(sqlQuery, arrayOf<String>(appPackageName))
        if (c.count == 1){
            var appUsage = ""
            while(c.moveToNext()){
                appUsage = c.getString(2)

            }
            appLimitedFor = appUsage.toInt()

        }
        return  appLimitedFor

    }


    fun getAppDuration(appPackageName:String,appName:String):Int {
        openDataBase()
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
            var todaysTime:String = DateHelper.instance.getCurrentTime()
            val lastUsedTime = todaysTime.getQuoted()


            val sql = "INSERT into DailyUsage (appName,appDuration,appPackageName,usedOn,lastActive,launchCount) VALUES(\"$appName\",\"0\",\"$appPackageName\",\"$todayDate\",$lastUsedTime,\"0\")"

            //val sql = "INSERT into DailyUsage (appName,appDuration,appPackageName,usedOn) VALUES($appdata,\"0\",\"$appPackageName\",\"$todayDate\")"
          Log.e("Insert Sql","$sql")

            db!!.execSQL(sql)
        }
        c.close()
            return appUsedFor
    }


    fun insertAppSessionRecord(appPackageName: String,sessionStartedOn:String, sessionEndedOn:String){
        openDataBase()
        val sql = "INSERT into $appsesionTable (packageName,startedAt,endOn) VALUES(${appPackageName.getQuoted()},${sessionStartedOn.getQuoted()},${sessionEndedOn.getQuoted()})"
        db!!.execSQL(sql)
        Log.e("Session Added ", "${appPackageName}")
    }

    fun updateCurrentSession(appPackageName: String,sessionStartedOn:String, sessionEndedOn:String){
        openDataBase()
        val updateSql:String = "Update $appsesionTable SET endOn = ${sessionEndedOn.getQuoted()} WHERE startedAt = ${sessionStartedOn.getQuoted()}"
        db!!.execSQL(updateSql)
        Log.e("Session Updated ", " started At${sessionStartedOn} endon ${sessionEndedOn}")
    }


    fun addOrUpdateAppDuration(appInfo:AppInfoModel){
        openDataBase()
        if(db != null){
            var todayDate:String = DateHelper.instance.getTodaysDate()
            var todaysTime:String = DateHelper.instance.getCurrentTime()
            val appduration = appInfo.timeUsedFor.getQuoted()
            val packageName = appInfo.appPackageName.getQuoted()
            val dateFor = todayDate.getQuoted()
            val lastUsedTime = todaysTime.getQuoted()
            val launchCount = appInfo.launchCount.getQuoted()
            val updateSql:String = "Update $dailyUsageTable SET appDuration = $appduration ,lastActive= $lastUsedTime, launchCount=$launchCount  WHERE appPackageName = $packageName AND usedOn = $dateFor "
//        val sqlString = "IF EXISTS(SELECT * FROM $dailyUsageTable WHERE appPackageName = ${appInfo.appPackageName} AND usedOn = ${todayDate})" + "THEN" +
//                "UPDATE $dailyUsageTable SET appDuration  = ${appInfo.timeUsedFor}  WHERE appPackageName = ${appInfo.appPackageName} AND usedOn = ${todayDate})" +
//                "ELSE" +
//                "INSERT INTO $dailyUsageTable (appName, appPackageName, appDuration, usedOn) VALUES(${appInfo.appname},${appInfo.appPackageName},${appInfo.timeUsedFor},${todayDate})"
            db!!.execSQL(updateSql)
        }
        Log.e("Updated data", "${appInfo.timeUsedFor}")


    }

    fun clearTableData(tableName:String){

        openDataBase()
        if(db != null){
            db!!.execSQL("Delete from $tableName")
        }
    }

    fun getAllApps(){
        openDataBase()
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