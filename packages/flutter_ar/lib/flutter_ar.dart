import 'dart:async';

import 'package:flutter/services.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart';
import 'arkit/image_detection.dart';
import 'arcore/image_detection.dart';

class FlutterARView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) return ARKitImageDetection();
    if (Platform.isAndroid) return Center(child: ARCoreImageDetection());
    return Container();
  }
}
