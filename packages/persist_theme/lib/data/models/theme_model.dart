import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../persist_theme.dart';
import '../file_storage.dart';
import '../persistence_repository.dart';

class ThemeModel extends Model {
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

  ThemeData _currentTheme = ThemeData.light();

  ThemeData get theme => _currentTheme;
  bool get isLoaded => loaded;

  void _loadTheme() {
    if (_settings?.darkMode ?? false) {
      _darkMode(trueBlack: _settings?.trueBlack ?? false);
    } else {
      _lightMode();
    }
  }

  void _darkMode({bool trueBlack = false}) {
    if (trueBlack) {
      _currentTheme = ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        backgroundColor: Colors.black,
        bottomAppBarColor: Colors.black,
        primaryColorDark: Colors.black,
      );
      notifyListeners();
      print("True Dark Mode Activated");
    } else {
      _currentTheme = ThemeData.dark();
      notifyListeners();
      print("Dark Mode Activated");
    }

    _settings.darkMode = true;
    _settings.trueBlack = trueBlack;
    notifyListeners();
    _saveToDisk();
  }

  void _lightMode() {
    if (_settings?.customTheme ?? false) {
      _currentTheme = ThemeData.light().copyWith(
        primaryColor: _settings?.primaryColor ?? Colors.blue,
        accentColor: _settings?.accentColor ?? Colors.redAccent,
      );
      notifyListeners();
      print("Custom Mode Activated");
    } else {
      _currentTheme = ThemeData.light();
      notifyListeners();
      print("Light Mode Activated");
    }

    _settings.darkMode = false;
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

  CustomThemeData _settings = _defaultSettings;

  static var _defaultSettings = CustomThemeData(
    // Defaults
    darkMode: false,
    trueBlack: false,
    customTheme: false,
    primaryColor: ThemeData.light().primaryColor,
    accentColor: ThemeData.light().accentColor,
    darkAccentColor: ThemeData.dark().accentColor,
  );

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
