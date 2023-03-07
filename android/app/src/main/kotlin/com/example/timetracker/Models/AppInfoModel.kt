package com.example.timetracker.Models

class AppInfoModel(appname:String, appPackageName:String, timeUsedFor:String, launchCount:String) {

    var appname:String = ""
    var appPackageName = ""
    var timeUsedFor:String = ""
    var launchCount:String = ""


    init {
        this.appname = appname
        this.appPackageName = appPackageName
        this.timeUsedFor = timeUsedFor
        this.launchCount = launchCount

    }
}