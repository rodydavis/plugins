package com.appleeducate.fluttersms;

import android.Manifest;
import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.provider.Settings;
import android.util.Log;

import java.util.ArrayList;
import java.util.Arrays;

import androidx.core.app.ActivityCompat;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterSmsPlugin */
public class FlutterSmsPlugin implements MethodCallHandler {
  Activity activity;

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_sms");
    channel.setMethodCallHandler(new FlutterSmsPlugin(registrar.activity()));
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("sendSMS")) {
      String message = call.argument("message");
      String recipients = call.argument("recipients");
      sendSMS(recipients, message);
      result.success("SMS Sent!" );
    } else {
      result.notImplemented();
    }
  }

  private FlutterSmsPlugin(Activity activity) {
    this.activity = activity;
  }

  private void sendSMS(String phones, String message) {
     Intent intent = new Intent(Intent.ACTION_VIEW);
     intent.setData(Uri.parse("smsto:" + phones));
     intent.putExtra("sms_body", message);
//     intent.putExtra(Intent.EXTRA_STREAM, attachment);
     if (intent.resolveActivity( activity.getPackageManager()) != null) {
       activity.startActivity(intent);
     }
  }
}
