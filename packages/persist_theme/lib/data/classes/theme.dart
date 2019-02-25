import 'package:flutter/material.dart';

part 'theme.g.dart';

class CustomThemeData {
  CustomThemeData({
    this.darkMode = false,
    this.trueBlack = false,
    this.primaryColor,
    this.accentColor,
    this.customTheme,
    this.darkAccentColor,
  });

  bool darkMode;

  bool trueBlack;

  bool customTheme;

  Color primaryColor;

  Color accentColor;

  Color darkAccentColor;

  factory CustomThemeData.fromJson(Map<String, dynamic> json) =>
      _$CustomThemeDataFromJson(json);

  Map<String, dynamic> toJson() => _$CustomThemeDataToJson(this);

  static Color _intToColor(int value) => Color(value ?? Colors.blue);

  static int _colorToInt(Color value) => value?.value ?? Colors.blue.value;
}
