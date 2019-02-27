import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'classes/theme.dart';
import 'file_storage.dart';

class PersistenceRepository {
  final FileStorage fileStorage;

  const PersistenceRepository({
    @required this.fileStorage,
  });

  Future<File> saveState(CustomThemeData state) async {
    var data = state.toJson();
    return await fileStorage.save(json.encode(data));
  }

  Future<CustomThemeData> loadState() async {
    String data = await fileStorage.load();
    return CustomThemeData.fromJson(json.decode(data));
  }

  Future<FileSystemEntity> delete() async {
    return await fileStorage
        .exists()
        .then((exists) => exists ? fileStorage.delete() : null);
  }

  Future<bool> exists() async {
    return await fileStorage.exists();
  }
}
