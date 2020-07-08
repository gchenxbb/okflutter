package com.example.flutterchannel;

import android.os.Bundle;
import android.os.Handler;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.view.FlutterView;

public class MainActivity extends FlutterActivity {
    private static final String CHARGING_CHANNEL = "com.pac.framework.plugins/battery_event";
    private int value = 0;

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        BinaryMessenger binaryMessenger = flutterEngine.getDartExecutor();
        ToastProviderPlugin.registerWith(this, binaryMessenger);
        BatteryLevelProviderPlugin.registerWith(this, binaryMessenger);
        StringDartProviderPlugin.registerWith(this, binaryMessenger);

        new EventChannel(binaryMessenger, CHARGING_CHANNEL).setStreamHandler(
                new EventChannel.StreamHandler() {

                    @Override
                    public void onListen(Object arguments, EventChannel.EventSink events) {
                        post(events);
                    }

                    @Override
                    public void onCancel(Object arguments) {

                    }
                }
        );

    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }


    private void post(EventChannel.EventSink events) {
        Handler mHandler = new Handler();
        Runnable r = new Runnable() {

            @Override
            public void run() {
                if (value < 15) {
                    value++;
                    events.success("hello events," + value);
                    mHandler.postDelayed(this, 1000);
                }
            }
        };
        mHandler.postDelayed(r, 100);//延时100毫秒
    }
}
