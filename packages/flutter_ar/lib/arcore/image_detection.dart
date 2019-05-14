import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:arcore_plugin/arcore_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ARCoreImageDetection extends StatefulWidget {
  @override
  _ARCoreImageDetectionState createState() => _ARCoreImageDetectionState();
}

class _ARCoreImageDetectionState extends State<ARCoreImageDetection> {
  String recongizedImage;
  ArCoreViewController arCoreViewController;
  bool _loaded = false;
  @override
  void initState() {
    _setup();
    super.initState();
  }

  void _setup() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    final Directory systemTempDir = Directory.systemTemp;
    final File tempFile = File('${systemTempDir.path}/image_database.imgdb');

    // create tempfile
    await tempFile.create();

    rootBundle.load("assets/image_database.imgdb").then((data) {
      tempFile.writeAsBytesSync(
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
      setState(() {
        _loaded = true;
      });
    }).catchError((error) {
      throw Exception(error);
    });
  }

  @override
  void dispose() {
    _loaded = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    if (!_loaded) return CircularProgressIndicator();
    return ArCoreView(
      focusBox: Container(
        width: screenSize.width * 0.5,
        height: screenSize.width * 0.5,
        decoration: BoxDecoration(
            border: Border.all(width: 1, style: BorderStyle.solid)),
      ),
      width: screenSize.width,
      height: screenSize.height,
      onImageRecognized: _onImageRecognized,
      onArCoreViewCreated: _onTextViewCreated,
    );
  }

  void _onTextViewCreated(ArCoreViewController controller) {
    arCoreViewController = controller;
    controller.getArCoreView();
  }

  void _onImageRecognized(String recImgName) {
    print("image recongized: $recImgName");

    // you can pause the image recognition via arCoreViewController.pauseImageRecognition();
    // resume it via arCoreViewController.resumeImageRecognition();
  }
}
