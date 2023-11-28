package com.app.consultormasterapp;


import com.digitalpersona.uareu.*;
import com.digitalpersona.uareu.Reader.Priority;

import com.digitalpersona.uareu.dpfpddusbhost.DPFPDDUsbHost;
import com.digitalpersona.uareu.dpfpddusbhost.DPFPDDUsbException;

import android.app.ActionBar;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Base64;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.os.Bundle;

import android.content.Context;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.IntentFilter;
import android.hardware.usb.UsbDevice;
import android.hardware.usb.UsbManager;

import android.content.Intent;
import android.view.View;

import com.google.android.gms.common.api.Status;

import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import androidx.annotation.NonNull;


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "metolChannel";
    private MethodChannel.Result scanResult;
    private final int GENERAL_ACTIVITY_RESULT = 1;
    private static final int SCAN_FINGER = 3;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    if (call.method.equals("startScan")) {
                        scanResult = result;
                        Intent i = new Intent(MainActivity.this, UareUSampleJava.class);
                        startActivityForResult(i, SCAN_FINGER);
                    } else {
                        result.notImplemented();
                    }
                });
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        Log.e("UareUSampleJava tonny", "ERROR ENCONTRADO tonny : " + requestCode + "  -  " + resultCode + "  -  " + data);
        if (requestCode == SCAN_FINGER) {
            Bitmap bmp = null;
            String temp = "";
            String filename = data.getStringExtra("img");
            try {
                FileInputStream is = openFileInput(filename);
                bmp = BitmapFactory.decodeStream(is);
                is.close();
                ByteArrayOutputStream baos=new  ByteArrayOutputStream();
                bmp.compress(Bitmap.CompressFormat.PNG,100, baos);
                byte [] b=baos.toByteArray();
                temp= Base64.encodeToString(b, Base64.DEFAULT);
            } catch (Exception e) {
                Log.e("finalScan", "ERROR ENCONTRADO finalScan : " + e.getMessage());
                e.printStackTrace();
            }

            Map scanResult2 = new HashMap<>();
            scanResult2.put("status", "RESULT_OK_OK");
            scanResult2.put("img", temp);
            scanResult.success(scanResult2);
        }
    }

}
