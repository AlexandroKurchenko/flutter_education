package com.example.flutter_app

import android.os.Bundle
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleObserver
import androidx.lifecycle.OnLifecycleEvent
import androidx.lifecycle.ViewModelProvider
import io.flutter.Log
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

const val CHANNEL = "com.example.flutter_app"
const val CALL_METHOD = "getSpecificInfo"
const val TAG = "MAIN_TAG"

class MainActivity : FlutterFragmentActivity(), MethodChannel.MethodCallHandler, LifecycleObserver {
    private lateinit var mainViewModel: MainActivityViewModel
    private lateinit var result: MethodChannel.Result

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        mainViewModel = ViewModelProvider(this).get(MainActivityViewModel::class.java)
        lifecycle.addObserver(this)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
                .setMethodCallHandler(this)
    }

    @OnLifecycleEvent(Lifecycle.Event.ON_CREATE)
    fun getSomeLongRunningDataResult() {
        mainViewModel.liveData.observe(this, { data ->
            Log.d(TAG, "Data observed from VM:$data")
            result.success(data)
        })
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        Log.d(TAG, "onMethodCall from ${call.method}")
        if (call.method == CALL_METHOD) {
            this.result = result
            mainViewModel.getSomeData()
        } else {
            result.notImplemented()
        }
    }
}
