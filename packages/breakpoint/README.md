[![Buy Me A Coffee](https://img.shields.io/badge/Donate-Buy%20Me%20A%20Coffee-yellow.svg)](https://www.buymeacoffee.com/rodydavis)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=WSH3GVC49GNNJ)


# breakpoint

## Overview

Follows Material Design [Docs](https://material.io/design/layout/responsive-layout-grid.html#breakpoints).

![breakpoint](https://github.com/AppleEducate/plugins/blob/master/packages/breakpoint/screenshots/breakpoint.png)

## Usage

When you are wanting to calculate the breakpoint of a widget that may not take up the full screen. This needs `BoxConstraints` but can be provided by the layout builder.

``` dart
final _breakpoint = Breakpoint.fromConstraints(constraints);
```

When a widget always takes up thye full screen.

``` dart
final _breakpoint = Breakpoint.fromMediaQuery(context);
```

Use `BreakpointBuilder` if you want the layout builder wrapped for you.

``` dart
return BreakpointBuilder(
    builder: (context, breakpoint) {
    print('Breakpoint: $breakpoint');
    return Container();
  },
);
```

## Example

``` dart
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:breakpoint/breakpoint.dart';

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      final _breakpoint = Breakpoint.fromConstraints(constraints);
      return Scaffold(
        appBar: AppBar(
          title: Text('Breakpoint Example: ${_breakpoint.toString()}'),
        ),
        body: Container(
          padding: EdgeInsets.all(_breakpoint.gutters),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _breakpoint.columns,
              crossAxisSpacing: _breakpoint.gutters,
              mainAxisSpacing: _breakpoint.gutters,
            ),
            itemCount: 200,
            itemBuilder: (_, index) {
              return Container(
                child: Card(
                  child: Text(
                    index.toString(),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}

```
