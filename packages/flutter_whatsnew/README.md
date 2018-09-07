# flutter_whatsnew

[![pub package](https://img.shields.io/pub/v/flutter_whatsnew.svg)](https://pub.dartlang.org/packages/flutter_whatsnew)

A Flutter Plugin to Show a Whats New page. Complete with only showing on version change.

## Usage

To use this plugin, add `flutter_whatsnew` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

``` dart
// Import package
import 'package:flutter_whatsnew/flutter_whatsnew.dart';
```


<p align="center"><img src ="example.png" width="300px"/></p>


## Example

``` dart
WhatsNewPage(
    title: Text(
    "What's New",
    textScaleFactor: textScaleFactor,
    textAlign: TextAlign.center,
    style: TextStyle(
        // Text Style Needed to Look like iOS 11
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
    ),
    ),
    buttonText: Text(
    'Continue',
    textScaleFactor: textScaleFactor,
    style: TextStyle(
        color: Colors.white,
    ),
    ),
    // Create a List of WhatsNewItem for use in the Whats New Page
    // Create as many as you need, it will be scrollable
    items: <ListTile>[
    ListTile(
        leading: Icon(Icons.color_lens),
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
        leading: Icon(Icons.map),
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
        leading: Icon(Icons.person_outline),
        title: Text(
        'Loan Contacts Enhancements',
        textScaleFactor: textScaleFactor,
        ),
        subtitle: Text(
        'Updated look for faster navigation',
        textScaleFactor: textScaleFactor,
        ),
        onTap: () {
            WhatsNewPage.showDetailPopUp(
            context,
            'Info',
            "Navigate to any loan then select the bottom right icon to go to the contacts. You can press the dropdown arrow for contact information.",
        );
        },
    ),
    ], //Required
    home: HomePage(), // Where the Button will Navigate (Usually the Login or Home Screen)
    showNow: false, // Show now regarless of version change (Useful for showing from the main menu)
    showOnVersionChange: true, //Show only if the version changes or the user reinstalls the app
),
```
