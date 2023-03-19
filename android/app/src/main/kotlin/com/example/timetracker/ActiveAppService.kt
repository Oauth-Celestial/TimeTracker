package com.example.timetracker

import android.app.*
import android.app.usage.UsageEvents
import android.app.usage.UsageStats
import android.app.usage.UsageStatsManager
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.os.Build
import android.os.CountDownTimer
import android.os.Handler
import android.os.IBinder
import android.util.Log
import android.widget.Toast
import androidx.core.app.NotificationCompat
import com.example.timetracker.Helpers.AppRestrictWindow
import com.example.timetracker.Models.AppInfoModel
import java.util.*

class ActiveAppService: Service() {
    private var iconNotification: Bitmap? = null
    private var notification: Notification? = null
    var mNotificationManager: NotificationManager? = null
    var window:AppRestrictWindow? = null
    var previousApp = ""
    var currentApp = ""


    private val mNotificationId = 123

    val TAG = "RaviForeground"
    private val builder = NotificationCompat.Builder(this, "service_channel")

// BuildForeGroundTaskNotification is responsible to build notification every time the foreground app change
    private fun buildForegroundTaskNotification() {

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            previousApp = currentApp

           currentApp = getTopPkgName(this)
            if(previousApp != currentApp){
                window?.close()
            }
        } else {
            val am = this.getSystemService(ACTIVITY_SERVICE) as ActivityManager
            val tasks = am.runningAppProcesses
            Log.e("Running Task","${tasks.size}")
            previousApp = currentApp
            currentApp = tasks[0].processName
            if(previousApp != currentApp){
                window?.close()
            }
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
            var appCount:Int = DatabaseHandler.instance.getAppLaunchCount(currentApp,appName)
            var isFocusModeApp = DatabaseHandler.instance.inFocusMode(currentApp);
            var focusModeAppDuration = -1
            if (isFocusModeApp){
                focusModeAppDuration = DatabaseHandler.instance.getFocusModeDurationFor(currentApp);
                if(appUsage > focusModeAppDuration ){
                    Log.e("Close Focus App",currentApp)
                    closeFocusModeApp()
                }
            }

            if (previousApp != currentApp){
                appCount += 1
            }

            DatabaseHandler.instance.addOrUpdateAppDuration(AppInfoModel(appName,currentApp,(appUsage +1).toString(),appCount.toString()))
            val icon: Drawable = this.packageManager.getApplicationIcon(currentApp)

            if(this.packageName == currentApp){
                builder.setContentTitle(
                        StringBuilder("Today's Device Usage").
                        toString()
                )
                        .setContentText("Today's Usage : ${convertSeconds(DatabaseHandler.instance.getTotalDeviceUsage())}") //
                        //                , swipe down for more options.

                        .setPriority(NotificationCompat.PRIORITY_LOW)
                        .setWhen(0)
                        .setOnlyAlertOnce(true)

                        .setSmallIcon(R.mipmap.ic_launcher)
                        .setContentIntent(pendingIntent)


                        .setOngoing(true)
            }
            else{
                builder.setContentTitle(
                        StringBuilder("App In Use: $appName").
                        toString()
                )
                        .setContentText("Today's Usage : ${convertSeconds(appUsage)} \n App Launch Count $appCount") //
                        //                , swipe down for more options.

                        .setPriority(NotificationCompat.PRIORITY_LOW)
                        .setWhen(0)
                        .setOnlyAlertOnce(true)

                        .setSmallIcon(R.mipmap.ic_launcher)
                        .setContentIntent(pendingIntent)


                        .setOngoing(true)
            }

            //
            if (iconNotification != null) {
                builder.setLargeIcon(Bitmap.createScaledBitmap(drawableToBitmap(icon)!!, 128, 128, false))
            }
//            builder.color =
            notification = builder.build()
            //DatabaseHandler.instance.getAllApps()
            if(Helper.isAppRunning(this,currentApp)){
                Log.e("App Is Running",currentApp)
            }
            else{
                Log.e("service is running For",currentApp)
            }


            val activeApp = getTopPkgName(this);
            Log.e("Current Active App","$currentApp")
            Log.e("fromTopPkg","$activeApp")


//
            if (currentApp == "com.lipisoft.quickvpn"){
                closeRestrictedApp()
            }

            mNotificationManager.notify(mNotificationId,notification);

        } catch (e: PackageManager.NameNotFoundException) {
            e.printStackTrace()
        }



    }

    fun drawableToBitmap(drawable: Drawable): Bitmap? {
        if (drawable is BitmapDrawable) {
            val bitmapDrawable: BitmapDrawable = drawable as BitmapDrawable
            if (bitmapDrawable.getBitmap() != null) {
                return bitmapDrawable.getBitmap()
            }
        }
        return if (drawable.intrinsicWidth <= 0 || drawable.intrinsicHeight <= 0) {
            Bitmap.createBitmap(1, 1, Bitmap.Config.ARGB_8888) // Single color bitmap will be created of 1x1 pixel
        } else {
            Bitmap.createBitmap(drawable.intrinsicWidth, drawable.intrinsicHeight, Bitmap.Config.ARGB_8888)
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
        window = AppRestrictWindow(this@ActiveAppService)

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

        return super.onStartCommand(intent, flags, startId)
    }

    fun closeFocusModeApp(){
        val startMain = Intent(Intent.ACTION_MAIN)
        startMain.addCategory(Intent.CATEGORY_HOME)
        startMain.flags = Intent.FLAG_ACTIVITY_NEW_TASK
        Toast.makeText(this, "Daily Usage Reached", Toast.LENGTH_SHORT).show()
        this.startActivity(startMain)
    }

    fun closeRestrictedApp(){

        window?.open()

//        val startMain = Intent(Intent.ACTION_MAIN)
//        startMain.addCategory(Intent.CATEGORY_HOME)
//        startMain.flags = Intent.FLAG_ACTIVITY_NEW_TASK
//        Toast.makeText(this, "Daily Usage Reached", Toast.LENGTH_SHORT).show()
//        this.startActivity(startMain)
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

                    .setOngoing(true)

//            if (iconNotification != null) {
//                builder.setLargeIcon(Bitmap.createScaledBitmap(iconNotification!!, 128, 128, false))
//            }
//            builder.color =
            notification = builder.build()

            startForeground(mNotificationId, notification)
            startContinue()

        }



    }

    object Helper {
        fun isAppRunning(context: Context, packageName: String?): Boolean {
            val activityManager = context.getSystemService(ACTIVITY_SERVICE) as ActivityManager
            val procInfos = activityManager.runningAppProcesses
            if (procInfos != null) {
                for (processInfo in procInfos) {
                    if (processInfo.processName.equals(packageName)) {
                        return true
                    }
                }
            }
            return false
        }
    }

    fun convertSeconds(seconds: Int): String? {
        val h = seconds / 3600
        val m = seconds % 3600 / 60
        val s = seconds % 60
        val sh = if (h > 0) "$h h" else ""
        val sm = (if (m < 10 &&( m > 0) && h > 0) "0" else "") + if (m > 0) (if (h > 0 && s == 0) m.toString() else "$m min") else ""
        val ss = if (s == 0 && (h > 0 || m > 0)) "" else (if (s < 10 && (h > 0 || m > 0)) "0" else "") + s.toString() + " " + "sec"
        return sh + (if (h > 0) " " else "") + sm + (if (m > 0) " " else "") + ss
    }

    fun getTopPkgName(context: Context): String {
        var pkgName: String? = null
        val usageStatsManager = context
                .getSystemService(USAGE_STATS_SERVICE) as UsageStatsManager
        val timeTnterval = (1000 * 600).toLong()
        val endTime = System.currentTimeMillis()
        val beginTime = endTime - timeTnterval
        val myUsageEvents: UsageEvents = usageStatsManager.queryEvents(beginTime, endTime)
        while (myUsageEvents.hasNextEvent()) {
            val myEvent: UsageEvents.Event = UsageEvents.Event()
            myUsageEvents.getNextEvent(myEvent)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                when (myEvent.eventType) {
                    UsageEvents.Event.ACTIVITY_RESUMED -> pkgName = myEvent.packageName
                    UsageEvents.Event.ACTIVITY_PAUSED -> if (myEvent.packageName.equals(pkgName)) {
                        pkgName = null
                    }
                }
            } else {
                when (myEvent.eventType) {
                    UsageEvents.Event.ACTIVITY_RESUMED -> pkgName = myEvent.packageName
                    UsageEvents.Event.ACTIVITY_RESUMED -> if (myEvent.packageName.equals(pkgName)) {
                        pkgName = null
                    }
                }
            }
        }
        if (pkgName == null){
            var currentApp = ""
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
            return currentApp
        }
        else{
            return  pkgName
        }

    }

    }