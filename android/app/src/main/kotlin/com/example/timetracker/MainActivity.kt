package com.example.timetracker

import android.content.Intent
import android.util.Log
import androidx.annotation.NonNull
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
                DatabaseHandler.instance.clearTableData("DailyUsage")



                val i = Intent(context, ActiveAppService::class.java)

                context.startService(i)
            }
            else {

            }
        }
    }


}
