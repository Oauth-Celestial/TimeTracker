package com.example.timetracker.Helpers

import java.text.SimpleDateFormat
import java.util.*

class DateHelper {
    companion object{
        var instance:DateHelper = DateHelper()
    }

    fun Date.toString(format: String, locale: Locale = Locale.getDefault()): String {
        val formatter = SimpleDateFormat(format, locale)
        return formatter.format(this)
    }

    fun getquoted(toquote:String):String{
        return "\"${toquote}\""
    }


    fun getTodaysDate():String{
        var todayDate:Date = Calendar.getInstance().time
        var formattedDate  = todayDate.toString("yyyy/MM/dd")
        return formattedDate
    }
}