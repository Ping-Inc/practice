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

    int lastDayOfNextMonth = DateTime(tempYear, tempMonth + 1, 0).day;
    int tempDay = day > lastDayOfNextMonth ? lastDayOfNextMonth : day;

    return DateTime(tempYear, tempMonth, tempDay);
  }

  DateTime previousMonth() {
    int tempYear = year;
    int tempMonth = month - 1;

    if (tempMonth < 1) {
      tempMonth = 12;
      tempYear -= 1;
    }

    int lastDayOfPreviousMonth = DateTime(tempYear, tempMonth + 1, 0).day;
    int tempDay = day > lastDayOfPreviousMonth ? lastDayOfPreviousMonth : day;

    return DateTime(tempYear, tempMonth, tempDay);
  }
}
