library sheet_music;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'util/clef_asset.dart';
import 'util/pitch_asset.dart';
import 'util/scale_asset.dart';
import 'package:jaguar/jaguar.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:jaguar_flutter_asset/jaguar_flutter_asset.dart';

const String sheetMusicPackageName = "sheet_music";

/// Transparent Sheet Music View with [black] color.
class SheetMusic extends StatefulWidget {
  final bool trebleClef;
  final String pitch, scale;

  /// Hide the Sheet Music View.
  final bool hide;

  /// Color of the [background], everything else will be [black].
  /// Defaults to [transparent].
  final Color backgroundColor;

  /// Called when the [clef] section is tapped.
  final VoidCallback clefTap;

  /// Called when the [scale] section is tapped.
  final VoidCallback scaleTap;

  /// Called when the [note] section is tapped.
  final VoidCallback pitchTap;

  /// Specify a [height] and [width] for the view. Default [197x100].
  final double width, height;

  SheetMusic({
    @required this.trebleClef,
    @required this.scale,
    @required this.pitch,
    this.pitchTap,
    this.clefTap,
    this.scaleTap,
    this.backgroundColor,
    this.hide,
    this.width,
    this.height,
  });

  @override
  _SheetMusicState createState() => _SheetMusicState();
}

class _SheetMusicState extends State<SheetMusic> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sheet Music View"),
      ),
      body: FutureBuilder<String>(
          future: LocalLoader().loadLocal(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return WebView(
                initialUrl:
                    new Uri.dataFromString(snapshot.data, mimeType: 'text/html')
                        .toString(),
                javascriptMode: JavascriptMode.unrestricted,
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          }),
    );
  }
}

class LocalLoader {
  Future<String> loadLocal() async {
    return await rootBundle.loadString('assets/sheet_music.html');
  }
}
