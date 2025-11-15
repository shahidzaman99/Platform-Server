package com.example.server; // Replace with your package name

import android.os.Build;
import android.os.Bundle;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {

    private static final String CHANNEL = "platformchannel.companyname.com/deviceinfo";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("getDeviceInfo")) {
                                String deviceInfo = getDeviceInfo();
                                result.success(deviceInfo);
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }

    // Method to get device info
    private String getDeviceInfo() {
        return "\nDevice: " + Build.DEVICE +
                "\nManufacturer: " + Build.MANUFACTURER +
                "\nModel: " + Build.MODEL +
                "\nProduct: " + Build.PRODUCT +
                "\nVersion Release: " + Build.VERSION.RELEASE +
                "\nVersion SDK: " + Build.VERSION.SDK_INT +
                "\nFingerprint: " + Build.FINGERPRINT;
    }
}
