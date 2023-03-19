package com.example.timetracker

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

class BootCompletedReceiver : BroadcastReceiver() {
    override fun onReceive(p0: Context?, p1: Intent?) {
        val i = Intent(p0, ActiveAppService::class.java)
        p0?.stopService(i)
        p0?.startService(i)
    }

}