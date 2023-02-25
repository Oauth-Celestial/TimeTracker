package com.example.timetracker

import android.app.*
import android.app.usage.UsageStats
import android.app.usage.UsageStatsManager
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.drawable.Drawable
import android.os.Build
import android.os.CountDownTimer
import android.os.Handler
import android.os.IBinder
import android.util.Log
import androidx.core.app.NotificationCompat
import com.example.timetracker.Models.AppInfoModel
import java.util.*

class ActiveAppService: Service() {
    private var iconNotification: Bitmap? = null
    private var notification: Notification? = null
    var mNotificationManager: NotificationManager? = null


    private val mNotificationId = 123

    val TAG = "RaviForeground"
    private val builder = NotificationCompat.Builder(this, "service_channel")

// BuildForeGroundTaskNotification is responsible to build notification every time the foreground app change
    private fun buildForegroundTaskNotification() {
        var currentApp = "NULL"
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val usm = this.getSystemService(USAGE_STATS_SERVICE) as UsageStatsManager
            val time = System.currentTimeMillis()
            val appList =
                    usm.queryUsageStats(UsageStatsManager.INTERVAL_DAILY, time - 1000 * 1000, time)
            if (appList != null && appList.size > 0) {
                val mySortedMap: SortedMap<Long, UsageStats> = TreeMap()
                for (usageStats in appList) {
                    mySortedMap[usageStats.lastTimeUsed] = usageStats
                }
                if (mySortedMap != null && !mySortedMap.isEmpty()) {
                    currentApp = mySortedMap[mySortedMap.lastKey()]!!.packageName
                }
            }
        } else {
            val am = this.getSystemService(ACTIVITY_SERVICE) as ActivityManager
            val tasks = am.runningAppProcesses
            currentApp = tasks[0].processName
        }
        val packageManager: PackageManager = applicationContext.packageManager
        val appName = packageManager.getApplicationLabel(packageManager.getApplicationInfo(currentApp, PackageManager.GET_META_DATA)) as String
//        Log.e(TAG, "Current App in foreground is: $currentApp")
//        Log.e(TAG, "Current AppNam in foreground is: $appName")
        val intentMainLanding = Intent(this, MainActivity::class.java)
        val pendingIntent =
                PendingIntent.getActivity(this, 0, intentMainLanding, PendingIntent.FLAG_IMMUTABLE)
        val mNotificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
        try {
            var appUsage:Int =  DatabaseHandler.instance.getAppDuration(currentApp,appName)

            DatabaseHandler.instance.addOrUpdateAppDuration(AppInfoModel(appName,currentApp,(appUsage +1).toString()))
            val icon: Drawable = this.packageManager.getApplicationIcon(currentApp)
            builder.setContentTitle(
                    StringBuilder(appName).
                    toString()
            )
                    .setContentText("App In Use: $appUsage") //                    , swipe down for more options.

                    .setPriority(NotificationCompat.PRIORITY_LOW)
                    .setWhen(0)
                    .setOnlyAlertOnce(true)
                    .setSmallIcon(R.drawable.launch_background)
                    .setContentIntent(pendingIntent)
                    .setOngoing(true)
            if (iconNotification != null) {
                builder.setLargeIcon(Bitmap.createScaledBitmap(iconNotification!!, 128, 128, false))
            }
//            builder.color =
            notification = builder.build()
            //DatabaseHandler.instance.getAllApps()


            mNotificationManager.notify(mNotificationId,notification);


        } catch (e: PackageManager.NameNotFoundException) {
            e.printStackTrace()
        }



    }

    fun getForegroundApplication(context: Context) {
        try {
            buildForegroundTaskNotification()

        } catch (e: Exception) {

            e.printStackTrace()
        }
    }


    override fun onBind(intent: Intent?): IBinder? {
        while (true) {
            Handler().postDelayed({
                Log.d(TAG, "onBind: Running")
            }, 100)
        }
        return null
    }




    override fun onCreate() {
        super.onCreate()
    }

    private fun startContinue() {
        val timer = object : CountDownTimer(Long.MAX_VALUE, 1000) {
            override fun onTick(millisUntilFinished: Long) {
                getForegroundApplication(this@ActiveAppService)
            }

            override fun onFinish() {
                Log.d(TAG, "onFinish: called")
            }
        }

        timer.start()
    }


    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        Log.d("Ravi", "onStartCommand: Started")
        generateForegroundNotification()
        startContinue()
        return super.onStartCommand(intent, flags, startId)
    }


    private fun generateForegroundNotification() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val intentMainLanding = Intent(this, MainActivity::class.java)
            val pendingIntent =
                    PendingIntent.getActivity(this, 0, intentMainLanding, PendingIntent.FLAG_IMMUTABLE)
            iconNotification = BitmapFactory.decodeResource(resources, R.mipmap.ic_launcher)
            if (mNotificationManager == null) {
                mNotificationManager =
                        this.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            }
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                assert(mNotificationManager != null)
                mNotificationManager?.createNotificationChannelGroup(
                        NotificationChannelGroup("chats_group", "Chats")
                )
                val notificationChannel =
                        NotificationChannel(
                                "service_channel", "Service Notifications",
                                NotificationManager.IMPORTANCE_MIN
                        )
                notificationChannel.enableLights(false)
                notificationChannel.lockscreenVisibility = Notification.VISIBILITY_SECRET
                mNotificationManager?.createNotificationChannel(notificationChannel)
            }


            builder.setContentTitle(
                    StringBuilder("Testing").append(" service is running")
                            .toString()
            )
                    .setTicker(
                            StringBuilder("Testing").append("service is running")
                                    .toString()
                    )
                    .setContentText("Touch to open") //                    , swipe down for more options.

                    .setPriority(NotificationCompat.PRIORITY_LOW)
                    .setWhen(0)
                    .setOnlyAlertOnce(true)
                    .setSmallIcon(R.drawable.launch_background)
                    .setContentIntent(pendingIntent)
                    .setOngoing(true)
            if (iconNotification != null) {
                builder.setLargeIcon(Bitmap.createScaledBitmap(iconNotification!!, 128, 128, false))
            }
//            builder.color =
            notification = builder.build()
            startForeground(mNotificationId, notification)
        }

    }




    }