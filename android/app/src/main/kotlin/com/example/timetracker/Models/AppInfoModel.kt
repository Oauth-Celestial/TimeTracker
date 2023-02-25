package com.example.timetracker.Models

class AppInfoModel(appname:String, appPackageName:String, timeUsedFor:String) {

    var appname:String = ""
    var appPackageName = ""
    var timeUsedFor:String = ""


    init {
        this.appname = appname
        this.appPackageName = appPackageName
        this.timeUsedFor = timeUsedFor

    }
}