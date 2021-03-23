package io.tintoll.native_example;

import android.os.Build;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private String CHANNEL = "com.flutter.dev/info";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        MethodChannel methodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL);
        methodChannel.setMethodCallHandler(((call, result) -> {
            if (call.method == "getDeviceInfo") {
                String deviceInfo = getDeviceInfo();
                result.success(deviceInfo);
            }
        }));
    }

    private String getDeviceInfo() {
        StringBuffer sb = new StringBuffer();
        sb.append(Build.DEVICE + "\n");
        sb.append(Build.BRAND + "\n");
        sb.append(Build.MODEL + "\n");
        return sb.toString();
    }
}
