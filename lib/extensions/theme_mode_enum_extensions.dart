import 'package:practice/enums/theme_mode_enum.dart';

extension StringParsingExtensions on ThemeModeEnum {
  String title() {
    switch (this) {
      case ThemeModeEnum.morning:
        return "morning";
      case ThemeModeEnum.afternoon:
        return "afternoon";
      case ThemeModeEnum.evening:
        return "evening";
      case ThemeModeEnum.night:
        return "night";
    }
  }
}

extension intParsing on ThemeModeEnum {
  int startingHour() {
    switch (this) {
      case ThemeModeEnum.morning:
        return 6;
      case ThemeModeEnum.afternoon:
        return 12;
      case ThemeModeEnum.evening:
        return 18;
      case ThemeModeEnum.night:
        return 23;
    }
  }

  int endingHour() {
    switch (this) {
      case ThemeModeEnum.morning:
        return 11;
      case ThemeModeEnum.afternoon:
        return 17;
      case ThemeModeEnum.evening:
        return 22;
      case ThemeModeEnum.night:
        return 5;
    }
  }
}
