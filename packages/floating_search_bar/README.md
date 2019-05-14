[![Buy Me A Coffee](https://img.shields.io/badge/Donate-Buy%20Me%20A%20Coffee-yellow.svg)](https://www.buymeacoffee.com/rodydavis)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=WSH3GVC49GNNJ)

# floating_search_bar

A Search App Bar like the one in Gmail and Google Photos.

## Getting Started

If you want to just use the floating bar as an app bar please use `SliverFloatingBar` otherwise use `FloatingSearchBar`.

![search](https://github.com/AppleEducate/plugins/blob/master/packages/floating_search_bar/screenshots/search.png)

if you add a drawer the menu icon will show up:

![drawer](https://github.com/AppleEducate/plugins/blob/master/packages/floating_search_bar/screenshots/drawer.png)

## Usage


``` dart
import 'package:flutter/material.dart';

import 'package:floating_search_bar/floating_search_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FloatingSearchBar.builder(
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text(index.toString()),
          );
        },
        trailing: CircleAvatar(
          child: Text("RD"),
        ),
        drawer: Drawer(
          child: Container(),
        ),
        onChanged: (String value) {},
        onTap: () {},
        decoration: InputDecoration.collapsed(
          hintText: "Search...",
        ),
      ),
    );
  }
}

```