package com.appleeducate.fluttersms;

import android.Manifest;
import android.app.Activity;
import android.content.Intent;
import android.content.pm.ActivityInfo;
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
      if (!canSendSMS()) {
        result.error(
          "device_not_capable",
          "The current device is not capable of sending text messages.",
          "A device may be unable to send messages if it does not support messaging or if it is not currently configured to send messages. This only applies to the ability to send text messages via iMessage, SMS, and MMS."
        );
        return;
      }

      String message = call.argument("message");
      String recipients = call.argument("recipients");
      sendSMS(recipients, message);
      result.success("SMS Sent!" );
    } else if (call.method.equals("canSendSMS")) {
      result.success(canSendSMS());
    } else {
      result.notImplemented();
    }
  }

  private FlutterSmsPlugin(Activity activity) {
    this.activity = activity;
  }

  private boolean canSendSMS() {
    if (!activity.getPackageManager().hasSystemFeature(PackageManager.FEATURE_TELEPHONY))
      return false;

    Intent intent = new Intent(Intent.ACTION_VIEW);
    intent.setData(Uri.parse("smsto:"));
    ActivityInfo activityInfo = intent.resolveActivityInfo(activity.getPackageManager(), intent.getFlags());
    if (activityInfo == null || !activityInfo.exported)
      return false;

    return true;
  }

  private void sendSMS(String phones, String message) {
    Intent intent = new Intent(Intent.ACTION_VIEW);
    intent.setData(Uri.parse("smsto:" + phones));
    intent.putExtra("sms_body", message);
//     intent.putExtra(Intent.EXTRA_STREAM, attachment);
    activity.startActivity(intent);
  }
}
