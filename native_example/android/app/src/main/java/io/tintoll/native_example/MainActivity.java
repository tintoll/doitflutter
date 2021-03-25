package io.tintoll.native_example;

import android.app.AlertDialog;
import android.os.Build;
import android.util.Base64;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private String CHANNEL = "com.flutter.dev/info";
    private String CHANNEL2 = "com.flutter.dev/encrypto";
    private String CHANNEL3 = "com.flutter.dev/dialog";

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

        MethodChannel methodChannel2 = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL2);
        methodChannel2.setMethodCallHandler(((call, result) -> {
            if (call.method == "getEncrypto") {
                byte[] bytes = call.arguments().toString().getBytes();
                String changeText = Base64.encodeToString(bytes, Base64.DEFAULT);
                result.success(changeText);
            } else if (call.method == "getDecode") {
                byte[] changeText = Base64.decode(call.arguments().toString(), Base64.DEFAULT);
                result.success(String.valueOf(changeText));
            }
        }));

        MethodChannel methodChannel3 = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL3);
        methodChannel3.setMethodCallHandler(((call, result) -> {
            if (call.method == "showDialog") {
                AlertDialog.Builder alertDialog = new AlertDialog.Builder(MainActivity.this);
                alertDialog.setTitle("Flutter");
                alertDialog.setMessage("네이트브에서 출력하는 창입니다.");
                alertDialog.show();
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
