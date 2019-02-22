package com.appleeducate.fluttersms;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import android.app.Activity;
import android.content.Intent;

import android.Manifest;
import android.content.pm.PackageManager;
import android.provider.Settings;
import androidx.core.app.ActivityCompat;
import android.util.Log;
import android.net.Uri;

import java.util.ArrayList;

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
      ArrayList<String> recipients = call.argument("recipients");
      String smsPermission = "SEND_SMS";
      if (!checkPermission(smsPermission)) {
        requestPermission(smsPermission);
        if (!checkPermission(smsPermission)) {
          openSettings();
        } else {
          sendSMS(recipients, message);
        }
      } else {
        sendSMS(recipients, message);
      }
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else {
      result.notImplemented();
    }
  }

  private FlutterSmsPlugin(Activity activity) {
    this.activity = activity;
  }

  private void sendSMS(ArrayList<String> phones, String message) {
    Intent sendIntent = new Intent(Intent.ACTION_VIEW);
    sendIntent.putExtra("sms_body", message);
    sendIntent.setData(Uri.parse("sms:" + phones));
    activity.startActivity(sendIntent);
  }

  private boolean checkPermission(String permission) {
    permission = getManifestPermission(permission);
    Log.i("SimplePermission", "Checking permission : " + permission);
    return PackageManager.PERMISSION_GRANTED == ActivityCompat.checkSelfPermission(activity, permission);
  }

  private void requestPermission(String permission) {
    permission = getManifestPermission(permission);
    Log.i("SimplePermission", "Requesting permission : " + permission);
    String[] perm = { permission };
    ActivityCompat.requestPermissions(activity, perm, 0);
  }

  private String getManifestPermission(String permission) {
    String res;
    switch (permission) {
    case "SEND_SMS":
      res = Manifest.permission.SEND_SMS;
      break;
    default:
      res = "ERROR";
      break;
    }
    return res;
  }

  private void openSettings() {
    Intent intent = new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS,
        Uri.parse("package:" + activity.getPackageName()));
    intent.addCategory(Intent.CATEGORY_DEFAULT);
    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
    activity.startActivity(intent);
  }
}
