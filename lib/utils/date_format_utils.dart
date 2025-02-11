import 'package:intl/intl.dart';

class DateFormatUtils {
  DateFormatUtils._();

  static String formatForPing(DateTime time) {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);
    final startOfYesterday = startOfToday.subtract(Duration(days: 1));
    final startOfWeek = startOfToday.subtract(Duration(days: now.weekday - 1));
    final startOfYear = DateTime(now.year);

    if (time.isAfter(startOfToday)) {
      return 'today, ${_timeOfDayFormat(time)}';
    } else if (time.isAfter(startOfYesterday)) {
      return 'yesterday, ${_timeOfDayFormat(time)}';
    } else if (time.isAfter(startOfWeek)) {
      return '${_dayOfWeekFormat(time)}, ${_timeOfDayFormat(time)}';
    } else if (time.isAfter(startOfYear)) {
      return '${_dateOfMonthFormate(time)}, ${_timeOfDayFormat(time)}';
    } else {
      return '${_dateOfMonthFormate(time)}, ${_yearFormat(time)} • ${_timeOfDayFormat(time)}';
    }
  }

  static String _timeOfDayFormat(DateTime time) {
    return DateFormat.jm().format(time).toLowerCase();
  }

  static String _dayOfWeekFormat(DateTime time) {
    return DateFormat.EEEE().format(time).toLowerCase();
  }

  static String _dateOfMonthFormate(DateTime time) {
    return DateFormat.MMMM().format(time).toLowerCase() +
        ' ' +
        time.day.toString();
  }

  static String _yearFormat(DateTime time) {
    return time.year.toString().toLowerCase();
  }
}
