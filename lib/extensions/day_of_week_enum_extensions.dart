import 'package:practice/enums/day_of_week_enum.dart';

extension StringParsingExtensions on DayOfWeekEnum {
  String title() {
    switch (this) {
      case DayOfWeekEnum.monday:
        return "monday";
      case DayOfWeekEnum.tuesday:
        return "tuesday";
      case DayOfWeekEnum.wednesday:
        return "wednesday";
      case DayOfWeekEnum.thursday:
        return "thursday";
      case DayOfWeekEnum.friday:
        return "friday";
      case DayOfWeekEnum.saturday:
        return "saturday";
      case DayOfWeekEnum.sunday:
        return "sunday";
    }
  }
}
