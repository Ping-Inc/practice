import 'package:practice/enums/theme_mode_enum.dart';

extension ThemeModesEnumExtension on DateTime {
  ThemeModeEnum themeMode() {
    final hour = this.hour;
    if (hour >= 6 && hour < 11) {
      return ThemeModeEnum.morning;
    } else if (hour >= 11 && hour < 17) {
      return ThemeModeEnum.afternoon;
    } else if (hour >= 17 && hour < 22) {
      return ThemeModeEnum.evening;
    } else {
      return ThemeModeEnum.night;
    }
  }
}

extension DateTimeExtensions on DateTime {
  DateTime nextMonth() {
    int tempYear = year;
    int tempMonth = month + 1;

    if (tempMonth > 12) {
      tempMonth = 1;
      tempYear += 1;
    }

    return DateTime(tempYear, tempMonth, 15);
  }

  DateTime previousMonth() {
    int tempYear = year;
    int tempMonth = month - 1;

    if (tempMonth < 1) {
      tempMonth = 1;
      tempYear -= 1;
    }

    return DateTime(tempYear, tempMonth, 15);
  }
}
