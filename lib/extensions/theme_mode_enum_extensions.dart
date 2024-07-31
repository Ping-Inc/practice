import 'package:flutter/material.dart';
import 'package:practice/enums/theme_mode_enum.dart';
import 'package:practice/utils/theme_utils.dart';

extension ThemeDataExtension on ThemeModeEnum {
  ThemeData data() {
    switch (this) {
      case ThemeModeEnum.morning:
        return ThemeUtils.themeForThemeEnum(
            Brightness.light, ThemeModeEnum.morning);
      case ThemeModeEnum.afternoon:
        return ThemeUtils.themeForThemeEnum(
            Brightness.light, ThemeModeEnum.afternoon);
      case ThemeModeEnum.evening:
        return ThemeUtils.themeForThemeEnum(
            Brightness.dark, ThemeModeEnum.evening);
      case ThemeModeEnum.night:
        return ThemeUtils.themeForThemeEnum(
            Brightness.dark, ThemeModeEnum.night);
    }
  }
}

extension StringParsingExtensions on ThemeModeEnum {
  String toTitle() {
    switch (this) {
      case ThemeModeEnum.morning:
        return "Morning";
      case ThemeModeEnum.afternoon:
        return "Afternoon";
      case ThemeModeEnum.evening:
        return "Evening";
      case ThemeModeEnum.night:
        return "Night";
    }
  }
}
