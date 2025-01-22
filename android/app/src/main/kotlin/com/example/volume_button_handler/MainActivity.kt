package com.example.volume_button_handler

import android.os.Bundle
import android.view.KeyEvent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private val CHANNEL = "com.example.volume_button_handler"
    private lateinit var methodChannel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        methodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        )
    }

    override fun dispatchKeyEvent(event: KeyEvent): Boolean {
        if (event.action == KeyEvent.ACTION_DOWN) {
            when (event.keyCode) {
                KeyEvent.KEYCODE_VOLUME_UP -> {
                    android.util.Log.d("MainActivity", "Volume Up Pressed!")
                    // Send a "volumeUpPressed" event to Flutter
                    methodChannel.invokeMethod("volumeUpPressed", null)
                    // Return true to consume the event,so it doesn't change the volume
                    return true
                }
                KeyEvent.KEYCODE_VOLUME_DOWN -> {
                    android.util.Log.d("MainActivity", "Volume Down Pressed!")
                    // Send a "volumeDownPressed" event to Flutter
                    methodChannel.invokeMethod("volumeDownPressed", null)
                    // Return true to consume the event
                    return true
                }
            }
        }
        // If it's not one of our desired key events, pass it to the super method.
        return super.dispatchKeyEvent(event)
    }
}

