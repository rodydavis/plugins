import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:scoped_model/scoped_model.dart';

enum ThemeType { light, dark, custom, black }

class ThemeModel extends Model {
  ThemeModel({
    this.customBlackTheme,
    this.customLightTheme,
    this.customDarkTheme,
    this.customCustomTheme,
    String key,
  }) : _storage = LocalStorage(key ?? "app_theme");

  final ThemeData customLightTheme,
      customDarkTheme,
      customBlackTheme,
      customCustomTheme;

  int _accentColor = Colors.redAccent.value;
  bool _customTheme = false;
  int _darkAccentColor = Colors.greenAccent.value;
  bool _darkMode = false;
  int _primaryColor = Colors.blue.value;
  LocalStorage _storage;
  bool _trueBlack = false;

  ThemeType get type {
    if (_darkMode ?? false) {
      if (_trueBlack ?? false) return ThemeType.black;
      return ThemeType.dark;
    }
    if (_customTheme ?? false) return ThemeType.custom;
    return ThemeType.light;
  }

  void changeDarkMode(bool value) {
    _darkMode = value;
    _storage.setItem("dark_mode", _darkMode);
    notifyListeners();
  }

  void changeTrueBlack(bool value) {
    _trueBlack = value;
    _storage.setItem("true_black", _trueBlack);
    notifyListeners();
  }

  void changeCustomTheme(bool value) {
    _customTheme = value;
    _storage.setItem("custom_theme", _customTheme);
    notifyListeners();
  }

  void changePrimaryColor(Color value) {
    _primaryColor = value.value;
    _storage.setItem("primary_color", _primaryColor);
    notifyListeners();
  }

  void changeAccentColor(Color value) {
    _accentColor = value.value;
    _storage.setItem("accent_color", _accentColor);
    notifyListeners();
  }

  void changeDarkAccentColor(Color value) {
    _darkAccentColor = value.value;
    _storage.setItem("dark_accent_color", _darkAccentColor);
    notifyListeners();
  }

  ThemeData get theme {
    if (_storage == null) {
      init();
    }
    switch (type) {
      case ThemeType.light:
        return customLightTheme ?? ThemeData.light().copyWith();
      case ThemeType.dark:
        return customDarkTheme ??
            ThemeData.dark().copyWith(
              accentColor: darkAccentColor ?? null,
            );
      case ThemeType.black:
        return customBlackTheme ??
            ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Colors.black,
              backgroundColor: Colors.black,
              bottomAppBarColor: Colors.black,
              primaryColorDark: Colors.black,
              accentColor: darkAccentColor ?? null,
            );
      case ThemeType.custom:
        return customCustomTheme != null
            ? customCustomTheme.copyWith(
                primaryColor: primaryColor ?? Colors.blue,
                accentColor: accentColor ?? Colors.redAccent,
              )
            : ThemeData.light().copyWith(
                primaryColor: primaryColor ?? Colors.blue,
                accentColor: accentColor ?? Colors.redAccent,
              );
      default:
        return customLightTheme ?? ThemeData.light().copyWith();
    }
  }

  Color get backgroundColor {
    if (darkMode ?? false) {
      if (trueBlack ?? false) return Colors.black;
      return ThemeData.dark().scaffoldBackgroundColor;
    }
    if (customTheme ?? false) return primaryColor;
    return null;
  }

  Color get textColor {
    if (customTheme ?? false) return Colors.white;
    if (darkMode ?? false) return Colors.white;
    return Colors.black;
  }

  Future init() async {
    if (await _storage.ready) {
      _darkMode = _storage.getItem("dark_mode");
      _trueBlack = _storage.getItem("true_black");
      _customTheme = _storage.getItem("custom_theme");
      _primaryColor = _storage.getItem("primary_color");
      _accentColor = _storage.getItem("accent_color");
      _darkAccentColor = _storage.getItem("dark_accent_color");
      notifyListeners();
    } else {
      print("Error Loading Theme...");
    }
  }

  bool get darkMode =>
      _darkMode ?? (type == ThemeType.dark || type == ThemeType.black);

  bool get trueBlack => _trueBlack ?? type == ThemeType.black;

  bool get customTheme => _customTheme ?? type == ThemeType.custom;

  Color get primaryColor {
    if (_primaryColor == null) {
      return type == ThemeType.dark
          ? ThemeData.dark().primaryColor
          : ThemeData.light().primaryColor;
    }
    return Color(_primaryColor);
  }

  Color get accentColor {
    if (type == ThemeType.dark || type == ThemeType.black) {
      if (_darkAccentColor == null) {
        return ThemeData.dark().accentColor;
      }
      return Color(_darkAccentColor);
    }

    if (_accentColor == null) {
      return ThemeData.light().accentColor;
    }

    if (_customTheme) {
      return Color(_accentColor);
    }

    return Colors.redAccent;
  }

  Color get darkAccentColor {
    if (_darkAccentColor == null) return ThemeData.dark().accentColor;
    return Color(_darkAccentColor);
  }

  void reset() {
    _storage.clear();
    _darkMode = false;
    _trueBlack = false;
    _customTheme = false;
    _primaryColor = Colors.blue.value;
    _accentColor = Colors.redAccent.value;
    _darkAccentColor = Colors.greenAccent.value;
  }
}
