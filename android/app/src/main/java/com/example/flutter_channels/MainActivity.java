package com.example.flutter_channels;
import android.os.Bundle;
import android.os.Handler;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.view.FlutterView;

public class MainActivity extends FlutterActivity {
    private static final String CHARGING_CHANNEL = "com.pac.framework.plugins/battery_event";
    private int value = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        ToastProviderPlugin.registerWith(this, getFlutterView());
        BatteryLevelProviderPlugin.registerWith(this, getFlutterView());
        StringDartProviderPlugin.registerWith(this,getFlutterView() );

        new EventChannel((FlutterView) getFlutterView(), CHARGING_CHANNEL).setStreamHandler(
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
