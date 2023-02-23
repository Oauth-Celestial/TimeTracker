package com.example.timetracker

import android.app.ActivityManager
import android.app.Service
import android.content.ComponentName
import android.content.Intent
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.util.Log
import androidx.core.app.NotificationCompat

class ActiveAppService: Service() {
    override fun onBind(p0: Intent?): IBinder? {
        TODO("Not yet implemented")
    }
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {

        val notificationIntent = Intent(this, MainActivity::class.java)

// 1
        val notification = NotificationCompat.Builder(this, "tracker")
                .setContentTitle("")
                .setContentText("")


                .build()
        val mainHandler = Handler(Looper.getMainLooper())

        mainHandler.post(object : Runnable {
            override fun run() {

                getActiveApp()
                mainHandler.postDelayed(this, 1000)
            }
        })
        //startForeground(888, notification)
// 2
        return START_NOT_STICKY
    }

    private fun getActiveApp() {
        val am: ActivityManager = this.getSystemService(ACTIVITY_SERVICE) as ActivityManager
        val taskInfo: List<ActivityManager.RunningTaskInfo> = am.getRunningTasks(1)
        if (taskInfo.size > 0){
            Log.d("topActivity", "CURRENT Activity ::" + taskInfo[0].topActivity?.packageName)
        }

        //val componentInfo: ComponentName? = taskInfo[0].topActivity

    }
    }