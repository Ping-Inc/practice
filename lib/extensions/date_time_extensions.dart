import 'package:practice/enums/day_of_week_enum.dart';
import 'package:practice/enums/theme_mode_enum.dart';

extension ThemeModesEnumExtension on DateTime {
  ThemeModeEnum themeMode() {
    final hour = this.hour;
    if (hour >= 6 && hour < 12) {
      return ThemeModeEnum.morning;
    } else if (hour >= 12 && hour < 18) {
      return ThemeModeEnum.afternoon;
    } else if (hour >= 18 && hour < 23) {
      return ThemeModeEnum.evening;
    } else {
      return ThemeModeEnum.night;
    }
  }
}

extension DayOfWeekEnumExtensions on DateTime {
  DayOfWeekEnum dayOfWeek() {
    switch (this.weekday) {
      case DateTime.monday:
        return DayOfWeekEnum.monday;
      case DateTime.tuesday:
        return DayOfWeekEnum.tuesday;
      case DateTime.wednesday:
        return DayOfWeekEnum.wednesday;
      case DateTime.thursday:
        return DayOfWeekEnum.thursday;
      case DateTime.friday:
        return DayOfWeekEnum.friday;
      case DateTime.saturday:
        return DayOfWeekEnum.saturday;
      case DateTime.sunday:
        return DayOfWeekEnum.sunday;
      default:
        throw Exception('Invalid weekday');
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
