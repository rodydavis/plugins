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
