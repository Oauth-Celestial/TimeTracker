package com.example.timetracker

import android.content.Intent
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
                val i = Intent(context, ActiveAppService::class.java)
                context.startService(i)
            }
            else {

            }
        }
    }


}
