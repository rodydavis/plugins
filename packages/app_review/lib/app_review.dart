import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class AppReview {
  static const MethodChannel _channel = MethodChannel('app_review');

  static Future<String> get requestReview async {
    if (Platform.isIOS) {
      final String details = await _channel.invokeMethod('requestReview');
      return details;
    } else {
      final String details = await storeListing;
      return details;
    }
  }

  static Future<String> get writeReview async {
    if (Platform.isIOS) {
      final String _appID = await getiOSAppID;
      String details = '';
      final String _url =
          'itunes.apple.com/us/app/id$_appID?mt=8&action=write-review';
      if (await canLaunch("itms-apps://")) {
        print('launching store page');
        await launch("itms-apps://" + _url);
        details = 'Launched App Store Directly: $_url';
      } else {
        await launch("https://" + _url);
        details = 'Launched App Store: $_url';
      }
      return details;
    } else {
      final String details = await storeListing;
      return details;
    }
  }

  static Future<String> get storeListing async {
    String details = '';
    if (Platform.isIOS) {
      final String _appID = await getiOSAppID;
      await launch('https://itunes.apple.com/us/app/id$_appID?');
      details = 'Launched App Store';
    } else {
      final String _appID = await getAppID;
      if (await canLaunch("market://")) {
        print('launching store page');
        await launch("market://details?id=" + _appID);
        details = 'Launched App Store Directly: $_appID';
      } else {
        await launch("https://play.google.com/store/apps/details?id=" + _appID);
        details = 'Launched App Store: $_appID';
      }
    }
    return details;
  }

  static Future<String> get getAppID async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    final String appName = packageInfo.appName;
    final String packageName = packageInfo.packageName;
    final String version = packageInfo.version;
    final String buildNumber = packageInfo.buildNumber;

    print(
        "App Name: $appName\nPackage Name: $packageName\nVersion: $version\nBuild Number: $buildNumber");

    return packageName;
  }

  static Future<String> get getiOSAppID async {
    final String _appID = await getAppID;
    String _id = '';
    await http
        .get('http://itunes.apple.com/lookup?bundleId=$_appID')
        .then((dynamic response) {
      final Map<String, dynamic> _json = json.decode(response.body);
      _id = _json['results'][0]['trackId'].toString();
      print('Track ID: $_id');
    });
    return _id;
  }
}
