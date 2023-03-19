package com.example.timetracker.Helpers

import android.util.Log
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

    fun getCurrentSessionTime() : String{
        val date = Date()
        val sdf = SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault())

// Next, we'll format the date using the SimpleDateFormat object
        val formattedTime = sdf.format(date)

// Finally, we can use the formatted time string as needed
        return formattedTime
    }

    fun getCurrentTime():String{
        val date = Date()
        val sdf = SimpleDateFormat("hh:mm a", Locale.getDefault())

// Next, we'll format the date using the SimpleDateFormat object
        val formattedTime = sdf.format(date)

// Finally, we can use the formatted time string as needed
        return formattedTime
    }
}