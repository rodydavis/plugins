// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomThemeData _$CustomThemeDataFromJson(Map<String, dynamic> json) {
  return CustomThemeData(
      darkMode: json['darkMode'] as bool,
      trueBlack: json['trueBlack'] as bool,
      primaryColor: json['primaryColor'] == null
          ? null
          : CustomThemeData._intToColor(json['primaryColor'] as int),
      accentColor: json['accentColor'] == null
          ? null
          : CustomThemeData._intToColor(json['accentColor'] as int),
      customTheme: json['customTheme'] as bool,
      darkAccentColor: json['darkAccentColor'] == null
          ? null
          : CustomThemeData._intToColor(json['darkAccentColor'] as int));
}

Map<String, dynamic> _$CustomThemeDataToJson(CustomThemeData instance) =>
    <String, dynamic>{
      'darkMode': instance.darkMode,
      'trueBlack': instance.trueBlack,
      'customTheme': instance.customTheme,
      'primaryColor': instance.primaryColor == null
          ? null
          : CustomThemeData._colorToInt(instance.primaryColor),
      'accentColor': instance.accentColor == null
          ? null
          : CustomThemeData._colorToInt(instance.accentColor),
      'darkAccentColor': instance.darkAccentColor == null
          ? null
          : CustomThemeData._colorToInt(instance.darkAccentColor)
    };
