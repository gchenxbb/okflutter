package com.example.flutterchannel;

import android.content.Context;
import android.util.Log;
import android.widget.Toast;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * Toast弹窗
 */
public class ToastProviderPlugin implements MethodChannel.MethodCallHandler {
    private static final String TAG = "ToastProviderPlugin";

    public static final String CHANNEL = "com.pac.framework.plugins/toast";

    static MethodChannel channel;

    private Context context;

    private ToastProviderPlugin(Context context) {
        this.context = context;
    }

    public static void registerWith(Context context, BinaryMessenger messenger) {
        channel = new MethodChannel(messenger, CHANNEL);
        channel.setMethodCallHandler(new ToastProviderPlugin(context));
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        Log.d(TAG, methodCall.method);
        if (methodCall.method.equals("showToast")) {
            showToast(context, methodCall.argument("message").toString(), Toast.LENGTH_SHORT);
        }
        result.success("showComplete");
    }

    private static void showToast(Context context, String message, int duration) {
        Log.d(TAG, Thread.currentThread().getName());
        Toast.makeText(context, message, duration).show();
    }

}