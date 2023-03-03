package com.example.timetracker

import android.app.ActivityManager
import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.annotation.NonNull
import com.example.timetracker.Helpers.AppRestrictWindow
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    var methodChannelName:String = "timeTracker";
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, methodChannelName).setMethodCallHandler {
            call, result ->
            if(call.method == "getForegroundPackage") {
                val hashMap = call.arguments as HashMap<*,*> //Get the arguments as a HashMap

                val dbPath = hashMap["dbPath"]
                Log.e("DbPath","$dbPath")//Get the argument based on the key passed from Flutter
                DatabaseHandler.instance.dataBasePath = dbPath as String
                DatabaseHandler.instance.openDataBase(dbPath as String)
//                DatabaseHandler.instance.clearTableData("DailyUsage")



                val i = Intent(context, ActiveAppService::class.java)

                val isAlreadyRunning:Boolean = context.isMyServiceRunning(ActiveAppService::class.java)

                if (!isAlreadyRunning){
                    context.startService(i)
                    Log.e("Service Status","Started New Service")

                }
                else{
                    Log.e("Service Status","Already Running")
                }


            }
            else if (call.method == "drawOverLay"){
                val window = AppRestrictWindow(this)
                window.open()
            }

            else {

            }
        }
    }


    fun drawOverLay(){

    }


    fun Context.isMyServiceRunning(serviceClass: Class<*>): Boolean {
        val manager = this.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        return manager.getRunningServices(Integer.MAX_VALUE)
                .any { it.service.className == serviceClass.name }
    }

}
