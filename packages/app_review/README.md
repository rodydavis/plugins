# app_review
![alt text](https://github.com/AppleEducate/app_review/blob/master/screenshots/IMG_0024.PNG)

## Description
Flutter Plugin for Requesting and Writing Reviews in Google Play and the App Store. Apps have to be published for the app to be found correctly. Android only supports navigating to Store Listing in Google Play.

## How To Use
It's important to note that the App ID must match the App ID in Google Play and iTunes Connect. This can be changed in the Info.plist on iOS and app/build.gradle on Android. You will use this App ID for other services like Firebase, Admob and publishing the app. 

#### Android
Navigates to Store Listing in Google Play

#### iOS
For Requesting Reviews it is managed by Apple. You can call the code on the page load and if the user has "rate in apps" turned on Apple will send the request for the review pop up. 

In debug mode it will always display. 

This is the required way for requesting reviews after iOS 10.3.

```
import 'dart:io';
import 'package:app_review/app_review.dart';
import 'package:flutter/material.dart';

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      AppReview.requestReview.then((onValue) {
        print(onValue);
      });
    }
  }
```

## Example

```
import 'package:app_review/app_review.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
    AppReview.getAppID.then((onValue) {
      setState(() {
        appID = onValue;
      });
      print("App ID" + appID);
    });
  }

  String appID = "";
  String output = "";

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('App Review'),
        ),
        body: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
              new Container(
                height: 40.0,
              ),
              new ListTile(
                leading: new Icon(Icons.info),
                title: new Text('App ID'),
                subtitle: new Text(appID),
                  onTap: () {
                  AppReview.getAppID.then((onValue) {
                    setState(() {
                      output = onValue;
                    });
                    print(onValue);
                  });
                },
              ),
              new Divider(
                height: 20.0,
              ),
              new ListTile(
                leading: new Icon(
                  Icons.shop,
                ),
                title: new Text('View Store Page'),
                onTap: () {
                  AppReview.storeListing.then((onValue) {
                    setState(() {
                      output = onValue;
                    });
                    print(onValue);
                  });
                },
              ),
              new Divider(
                height: 20.0,
              ),
              new ListTile(
                leading: new Icon(
                  Icons.star,
                ),
                title: new Text('Request Review'),
                onTap: () {
                  AppReview.requestReview.then((onValue) {
                    setState(() {
                      output = onValue;
                    });
                    print(onValue);
                  });
                },
              ),
              new Divider(
                height: 20.0,
              ),
              new ListTile(
                leading: new Icon(
                  Icons.note_add,
                ),
                title: new Text('Write a New Review'),
                onTap: () {
                  AppReview.writeReview.then((onValue) {
                    setState(() {
                      output = onValue;
                    });
                    print(onValue);
                  });
                },
              ),
              new Divider(
                height: 20.0,
              ),
              new ListTile(
                title: new Text(output),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

```
