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
    this.defaultThemeSettings,
    this.type = ThemeType.light,
  });

  ThemeType type;

  final ThemeData customLightTheme, customDarkTheme, customBlackTheme;

  final CustomThemeData defaultThemeSettings;

  void changeDarkMode(bool value) {
    _settings.darkMode = value;
    _loadTheme();
    _saveToDisk();
    notifyListeners();
  }

  void changeTrueBlack(bool value) {
    _settings.trueBlack = value;
    _loadTheme();
    _saveToDisk();
    notifyListeners();
  }

  void changeCustomTheme(bool value) {
    _settings.customTheme = value;
    _loadTheme();
    _saveToDisk();
    notifyListeners();
  }

  void changePrimaryColor(Color value) {
    _settings.primaryColor = value;
    _saveToDisk();
    _loadTheme();
    notifyListeners();
  }

  void changeAccentColor(Color value) {
    _settings.accentColor = value;
    _saveToDisk();
    _loadTheme();
    notifyListeners();
  }

  void changeDarkAccentColor(Color value) {
    _settings.darkAccentColor = value;
    _saveToDisk();
    _loadTheme();
    notifyListeners();
  }

  ThemeData get theme {
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
        return ThemeData.light().copyWith(
          primaryColor: _settings?.primaryColor ?? Colors.blue,
          accentColor: _settings?.accentColor ?? Colors.redAccent,
        );
      default:
        return customLightTheme ?? ThemeData.light().copyWith();
    }
  }

  bool get isLoaded => loaded;

  void _loadTheme() {
    if (_settings?.darkMode ?? false) {
      _darkMode(trueBlack: _settings?.trueBlack ?? false);
    } else {
      _lightMode();
    }
  }

  void _darkMode({bool trueBlack = false}) {
    _settings.darkMode = true;
    _settings.trueBlack = trueBlack;
    type = trueBlack ? ThemeType.black : ThemeType.dark;
    print("Loaded Theme: $type");
    notifyListeners();
    _saveToDisk();
  }

  void _lightMode() {
    _settings.darkMode = false;
    type = settings?.customTheme ?? false ? ThemeType.custom : ThemeType.light;
    print("Loaded Theme: $type");
    _saveToDisk();
    notifyListeners();
  }

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

  static var _defaultSettings = CustomThemeData(
    darkMode: false,
    trueBlack: false,
    customTheme: false,
    primaryColor: ThemeData.light().primaryColor,
    accentColor: ThemeData.light().accentColor,
    darkAccentColor: ThemeData.dark().accentColor,
  );

  CustomThemeData _settings;
  CustomThemeData get settings =>
      _settings ?? defaultThemeSettings ?? _defaultSettings;

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
        _settings = defaultThemeSettings ?? _defaultSettings;
      } else {
        _settings = _appSettings;
      }

      loading = false;
      loaded = true;
      notifyListeners();
    }
    _loadTheme();
  }

  void _saveToDisk() {
    storage.saveState(_settings);
  }

  PersistenceRepository get storage =>
      PersistenceRepository(fileStorage: FileStorage(module));

  String get module => "custom_theme";
}
