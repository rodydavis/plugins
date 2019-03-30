library sheet_music;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'util/clef_asset.dart';
import 'util/pitch_asset.dart';
import 'util/scale_asset.dart';

const String sheetMusicPackageName = "sheet_music";

const String kNavigationExamplePage = '''
<html>

<head>
	<title> Sheet Music View </title>
</head>

<body>

	<div id="osmdCanvas" />

	<input type="file" id="files" name="files[]" multiple />
	<output id="list"></output>

	<script
		src="https://github.com/opensheetmusicdisplay/opensheetmusicdisplay/releases/download/0.7.0/opensheetmusicdisplay.min.js"></script>
	<script>
		function handleFileSelect(evt) {
			var maxOSMDDisplays = 10; // how many scores can be displayed at once (in a vertical layout)
			var files = evt.target.files; // FileList object
			var osmdDisplays = Math.min(files.length, maxOSMDDisplays);

			var output = [];
			for (var i = 0, file = files[i]; i < osmdDisplays; i++) {
				output.push("<li><strong>", escape(file.name), "</strong> </li>");
				output.push("<div id='osmdCanvas" + i + "'/>");
			}
			document.getElementById("list").innerHTML = "<ul>" + output.join("") + "</ul>";

			for (var i = 0, file = files[i]; i < osmdDisplays; i++) {
				if (!file.name.match('.*\.xml') && !file.name.match('.*\.musicxml')) {
					alert('You selected a non-xml file. Please select only music xml files.');
					continue;
				}

				var reader = new FileReader();

				reader.onload = (function (theFile) {
					return function (e) {
						var openSheetMusicDisplay = new opensheetmusicdisplay.OpenSheetMusicDisplay("osmdCanvas");
						openSheetMusicDisplay
							.load(e.target.result)
							.then(
								function () {
									//console.log("e.target.result: " + e.target.result);
									openSheetMusicDisplay.render();
									
								}
							);
					}
				})(file);
				reader.readAsText(file);
			}
		}

		document.getElementById("files").addEventListener("change", handleFileSelect, false);
	</script>
	<noscript>Sorry, your browser does not support JavaScript!</noscript>
</body>

</html>
''';

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
  WebViewController _controller;

  @override
  void initState() {
    _loadHtmlFromAssets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return WebView(
        initialUrl: '',
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        },
      );
    });
  }

  _loadHtmlFromAssets() async {
    _controller.loadUrl(Uri.dataFromString(kNavigationExamplePage,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
