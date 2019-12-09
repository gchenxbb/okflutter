package com.example.flutter_channels;

import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Handler;
import android.util.Log;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * 获取Dart层字符
 */
public class StringDartProviderPlugin implements MethodChannel.MethodCallHandler {
    private static final String TAG = "BatteryLevelPlugin";

    public static final String CHANNEL = "com.pac.framework.plugins/dart_string";

    static MethodChannel channel;

    private Context context;

    private StringDartProviderPlugin(Context context) {
        this.context = context;
    }

    public static void registerWith(Context context, BinaryMessenger messenger) {
        channel = new MethodChannel(messenger, CHANNEL);
        channel.setMethodCallHandler(new StringDartProviderPlugin(context));

        //访问dart
        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                channel.invokeMethod("getDartString", "我要去dart层了!");
            }
        }, 1000);
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        Log.d(TAG, methodCall.method);
    }

}