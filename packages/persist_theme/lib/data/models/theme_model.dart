import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../persist_theme.dart';
import '../file_storage.dart';
import '../persistence_repository.dart';

enum ThemeType { light, dark, custom, black }

class ThemeModel extends Model {
  ThemeModel({
    this.customBlackTheme,
    this.customLightTheme,
    this.customDarkTheme,
    this.customCustomTheme,
    this.type = ThemeType.light,
  });

  ThemeType type;

  ThemeType get _type {
    if (_settings?.darkMode ?? false) {
      if (_settings?.trueBlack ?? false) return ThemeType.black;
      return ThemeType.dark;
    }
    if (_settings?.customTheme ?? false) return ThemeType.custom;
    return ThemeType.light;
  }

  final ThemeData customLightTheme,
      customDarkTheme,
      customBlackTheme,
      customCustomTheme;

  void changeDarkMode(bool value) {
    _settings?.darkMode = value;
    type = _type;
    print("Loaded Theme: $type");
    notifyListeners();
    _saveToDisk();
  }

  void changeTrueBlack(bool value) {
    _settings?.trueBlack = value;
    type = _type;
    print("Loaded Theme: $type");
    notifyListeners();
    _saveToDisk();
  }

  void changeCustomTheme(bool value) {
    _settings?.customTheme = value;
    type = _type;
    print("Loaded Theme: $type");
    notifyListeners();
    _saveToDisk();
  }

  void changePrimaryColor(Color value) {
    _settings?.primaryColor = value;
    type = _type;
    print("Loaded Theme: $type");
    notifyListeners();
    _saveToDisk();
  }

  void changeAccentColor(Color value) {
    _settings?.accentColor = value;
    type = _type;
    print("Loaded Theme: $type");
    notifyListeners();
    _saveToDisk();
  }

  void changeDarkAccentColor(Color value) {
    _settings?.darkAccentColor = value;
    type = _type;
    print("Loaded Theme: $type");
    notifyListeners();
    _saveToDisk();
  }

  ThemeData get theme {
    if (_settings == null) {
      loadFromDisk();
    }
    switch (type) {
      case ThemeType.light:
        return customLightTheme ?? ThemeData.light().copyWith();
      case ThemeType.dark:
        return customDarkTheme ??
            ThemeData.dark().copyWith(
              accentColor: _settings?.darkAccentColor ?? null,
            );
      case ThemeType.black:
        return customBlackTheme ??
            ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Colors.black,
              backgroundColor: Colors.black,
              bottomAppBarColor: Colors.black,
              primaryColorDark: Colors.black,
              accentColor: _settings?.darkAccentColor ?? null,
            );
      case ThemeType.custom:
        return customCustomTheme != null
            ? customCustomTheme.copyWith(
                primaryColor: _settings?.primaryColor ?? Colors.blue,
                accentColor: _settings?.accentColor ?? Colors.redAccent,
              )
            : ThemeData.light().copyWith(
                primaryColor: _settings?.primaryColor ?? Colors.blue,
                accentColor: _settings?.accentColor ?? Colors.redAccent,
              );
      default:
        return customLightTheme ?? ThemeData.light().copyWith();
    }
  }

  bool get isLoaded => loaded;

  Color get backgroundColor {
    if (_settings?.darkMode ?? false) {
      if (_settings?.trueBlack ?? false) return Colors.black;
      return ThemeData.dark().scaffoldBackgroundColor;
    }
    if (_settings?.customTheme ?? false) return _settings.primaryColor;
    return null;
  }

  Color get primaryColor => theme.primaryColor;
  Color get accentColor => theme.accentColor;

  Color get textColor {
    if (_settings?.customTheme ?? false) return Colors.white;
    if (_settings?.darkMode ?? false) return Colors.white;
    return Colors.black;
  }

  bool loaded = false;
  bool loading = false;

  CustomThemeData get _defaultSettings => CustomThemeData(
        darkMode: type == ThemeType.dark || type == ThemeType.black,
        trueBlack: type == ThemeType.black,
        customTheme: type == ThemeType.custom,
        primaryColor: type == ThemeType.dark
            ? ThemeData.dark().primaryColor
            : ThemeData.light().primaryColor,
        accentColor: ThemeData.light().accentColor,
        darkAccentColor: ThemeData.dark().accentColor,
      );

  CustomThemeData _settings;

  CustomThemeData get settings {
    if (_settings == null) {
      loadFromDisk();
      return _defaultSettings;
    }
    return _settings;
  }

  Future loadFromDisk() async {
    if (!loading) {
      loading = true;
      CustomThemeData _appSettings;
      try {
        _appSettings = await storage.loadState();
      } catch (e) {
        print("Error Loading App State => $e");
      }
      if (_appSettings == null) {
        _settings = _defaultSettings;
      } else {
        _settings = _appSettings;
        if (_settings.darkMode) {
          if (_settings.trueBlack) {
            type = ThemeType.black;
          } else {
            type = ThemeType.dark;
          }
        } else if (_settings.customTheme) {
          type = ThemeType.custom;
        } else {
          type = ThemeType.light;
        }
      }

      loading = false;
      loaded = true;
      notifyListeners();
    }
  }

  void _saveToDisk() {
    storage.saveState(_settings);
  }

  PersistenceRepository get storage =>
      PersistenceRepository(fileStorage: FileStorage(module));

  String get module => "custom_theme";
}
