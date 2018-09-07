package com.appleeducate.appreview;

import android.Manifest;
import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.provider.Settings;
import android.util.Log;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.common.PluginRegistry;

/**
 * AppReviewPlugin
 */
public class AppReviewPlugin implements MethodCallHandler {
  /**
   * Plugin registration.
   */

  private Registrar registrar;
  private Result result;
  String appPackageName = "";

  /**
   * Plugin registration.
   */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "app_review");
    AppReviewPlugin simplePermissionsPlugin = new AppReviewPlugin(registrar);
    channel.setMethodCallHandler(simplePermissionsPlugin);
//    registrar.addRequestPermissionsResultListener(simplePermissionsPlugin);
  }

  private AppReviewPlugin(Registrar registrar) {
    this.registrar = registrar;
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    String method = call.method;
    switch (method) {
      // case "getAppID":
      //   result.success("" + BuildConfig.APPLICATION_ID);
      //   break;
      default:
        result.notImplemented();
        break;
    }
  }

    // private void openListing(String appID) {
    //     Activity activity = registrar.activity();
    //     try {
    //         activity.startActivity(new Intent(Intent.ACTION_VIEW, Uri.parse("market://details?id=" + appID)));
    //     } catch (android.content.ActivityNotFoundException anfe) {
    //         activity.startActivity(new Intent(Intent.ACTION_VIEW, Uri.parse("https://play.google.com/store/apps/details?id=" + appID)));
    //     }
    // }

}
