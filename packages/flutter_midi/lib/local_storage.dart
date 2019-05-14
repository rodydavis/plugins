import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<File> writeToFile(ByteData data,
    {String name = "instrument.sf2"}) async {
  final buffer = data.buffer;
  final directory = await _getDocumentDir();
  final path = "${directory.path}/$name";
  return File(path)
      .writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}

Future<Directory> _getDocumentDir() async {
  if (Platform.isMacOS || Platform.isLinux) {
    return Directory('${Platform.environment['HOME']}/.config');
  } else if (Platform.isWindows) {
    return Directory('${Platform.environment['UserProfile']}\\.config');
  }
  return await getApplicationDocumentsDirectory();
}
