import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'theme.g.dart';

@JsonSerializable()
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

  @JsonKey(toJson: _colorToInt, fromJson: _intToColor)
  dynamic primaryColor;

  @JsonKey(toJson: _colorToInt, fromJson: _intToColor)
  Color accentColor;

  @JsonKey(toJson: _colorToInt, fromJson: _intToColor)
  Color darkAccentColor;

  factory CustomThemeData.fromJson(Map<String, dynamic> json) =>
      _$CustomThemeDataFromJson(json);

  Map<String, dynamic> toJson() => _$CustomThemeDataToJson(this);

  static Color _intToColor(int value) => Color(value ?? Colors.blue);

  static int _colorToInt(Color value) => value?.value ?? Colors.blue.value;
}
