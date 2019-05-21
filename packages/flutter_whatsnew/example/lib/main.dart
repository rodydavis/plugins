import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_whatsnew/flutter_whatsnew.dart';

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

// The existing imports
// !! Keep your existing impots here !!

/// main is entry point of Flutter application
void main() {
  // Desktop platforms aren't a valid platform.
  _setTargetPlatformForDesktop();

  return runApp(MyApp());
}

/// If the current platform is desktop, override the default platform to
/// a supported platform (iOS for macOS, Android for Linux and Windows).
/// Otherwise, do nothing.
void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}

class MyApp extends StatelessWidget {
  final double textScaleFactor = 1.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text("Show Changelog"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WhatsNewPage.changelog(
                              title: Text(
                                "What's New",
                                textScaleFactor: textScaleFactor,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  // Text Style Needed to Look like iOS 11
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              buttonText: Text(
                                'Continue',
                                textScaleFactor: textScaleFactor,
                                // style: const TextStyle(color: Colors.white),
                              ),
                            ),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                ),
                Container(height: 50.0),
                RaisedButton(
                  child: Text("Show Changes"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WhatsNewPage(
                              title: Text(
                                "What's New",
                                textScaleFactor: textScaleFactor,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  // Text Style Needed to Look like iOS 11
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              buttonText: Text(
                                'Continue',
                                textScaleFactor: textScaleFactor,
                                // style: const TextStyle(color: Colors.white),
                              ),
                              // Create a List of WhatsNewItem for use in the Whats New Page
                              // Create as many as you need, it will be scrollable
                              items: <ListTile>[
                                ListTile(
                                  leading: const Icon(Icons.color_lens),
                                  title: Text(
                                    'Dark Theme',
                                    textScaleFactor: textScaleFactor,
                                  ), //Title is the only Required Item
                                  subtitle: Text(
                                    'Black and grey theme (Tap to Change)',
                                    textScaleFactor: textScaleFactor,
                                  ),
                                  onTap: () {
                                    // You Can Navigate to Locations in the App
                                    Navigator.of(context).pushNamed("/settings");
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.map),
                                  title: Text(
                                    'Google Maps',
                                    textScaleFactor: textScaleFactor,
                                  ),
                                  subtitle: Text(
                                    'Open Address Links in Google Maps instead of Apple Maps (Tap to Change)',
                                    textScaleFactor: textScaleFactor,
                                  ),
                                  onTap: () {
                                    // You Can Navigate to Locations in the App
                                    Navigator.of(context).pushNamed("/settings");
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.notifications_active),
                                  title: Text(
                                    'Push Notifications',
                                    textScaleFactor: textScaleFactor,
                                  ),
                                  subtitle: Text(
                                    'Stay tuned for important information that can be pushed to you',
                                    textScaleFactor: textScaleFactor,
                                  ),
                                  onTap: () {
                                    WhatsNewPage.showDetailPopUp(
                                      context,
                                      'Info',
                                      "You can turn off push notifications any time in your application settings.",
                                    );
                                  },
                                ),
                              ], //Required
                            ),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
