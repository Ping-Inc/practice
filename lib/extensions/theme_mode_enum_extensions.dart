import 'package:practice/enums/theme_mode_enum.dart';

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

extension intParsing on ThemeModeEnum {
  int startingHour() {
    switch (this) {
      case ThemeModeEnum.morning:
        return 6;
      case ThemeModeEnum.afternoon:
        return 11;
      case ThemeModeEnum.evening:
        return 17;
      case ThemeModeEnum.night:
        return 22;
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
        return 6;
    }
  }
}
