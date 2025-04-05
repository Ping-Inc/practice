import 'package:intl/intl.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_grid.dart';

class PingDateUtils {
  PingDateUtils._();

  // Date Categories
  static DateCategory getDateCategory(
    DateTime date, {
    required DateTime today,
    required DateTime yesterday,
    required DateTime startOfYear,
  }) {
    if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day) {
      return DateCategory.today;
    } else if (date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day) {
      return DateCategory.yesterday;
    } else if (date.isAfter(startOfYear)) {
      return DateCategory.thisYear;
    } else {
      return DateCategory.pastYear;
    }
  }

  // Date Formatting
  static String formatForPing(DateTime time) {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);
    final startOfYesterday = startOfToday.subtract(const Duration(days: 1));
    final startOfWeek = startOfToday.subtract(Duration(days: now.weekday - 1));
    final startOfYear = DateTime(now.year);

    if (time.isAfter(startOfToday)) {
      return 'today, ${_timeOfDayFormat(time)}';
    } else if (time.isAfter(startOfYesterday)) {
      return 'yesterday, ${_timeOfDayFormat(time)}';
    } else if (time.isAfter(startOfWeek)) {
      return '${_dayOfWeekFormat(time)}, ${_timeOfDayFormat(time)}';
    } else if (time.isAfter(startOfYear)) {
      return '${_dateOfMonthFormat(time)}, ${_timeOfDayFormat(time)}';
    } else {
      return '${_dateOfMonthFormat(time)}, ${_yearFormat(time)} • ${_timeOfDayFormat(time)}';
    }
  }

  static String formatForGridHeader(DateTime date, DateCategory category) {
    final monthAbbr = DateFormat('MMM').format(date);
    final dayOfMonth = date.day.toString();
    final dayOfWeek = DateFormat('EEEE').format(date);

    switch (category) {
      case DateCategory.today:
        return 'today, $monthAbbr $dayOfMonth';
      case DateCategory.yesterday:
        return 'yesterday, $monthAbbr $dayOfMonth';
      case DateCategory.thisYear:
        return '$dayOfWeek, $monthAbbr $dayOfMonth';
      case DateCategory.pastYear:
        return '$dayOfWeek, $monthAbbr $dayOfMonth, ${date.year}';
    }
  }

  // Date Sorting
  static void sortDateGroups(List<DateGroup> groups) {
    groups.sort((a, b) {
      // First sort by category priority
      int categoryComparison = a.category.index.compareTo(b.category.index);
      if (categoryComparison != 0) {
        return categoryComparison;
      }

      // If same category, sort by date (most recent first)
      return b.date.compareTo(a.date);
    });
  }

  static void sortPingsByTime(List<PingData> pings,
      {bool sortByResonance = false}) {
    pings.sort((a, b) {
      final aTime =
          sortByResonance && a.resonantTime != null ? a.resonantTime! : a.time;
      final bTime =
          sortByResonance && b.resonantTime != null ? b.resonantTime! : b.time;
      return bTime.compareTo(aTime);
    });
  }

  // Private formatting helpers
  static String _timeOfDayFormat(DateTime time) {
    return DateFormat.jm().format(time).toLowerCase();
  }

  static String _dayOfWeekFormat(DateTime time) {
    return DateFormat.EEEE().format(time).toLowerCase();
  }

  static String _dateOfMonthFormat(DateTime time) {
    return DateFormat.MMMM().format(time).toLowerCase() +
        ' ' +
        time.day.toString();
  }

  static String _yearFormat(DateTime time) {
    return time.year.toString().toLowerCase();
  }

  // Week Range Calculation
  static (DateTime start, DateTime end) getLastWeekRange() {
    final now = DateTime.now();
    // Get the start of the current week (Monday)
    final currentWeekStart = now.subtract(Duration(days: now.weekday - 1));
    // Get the start of last week (Monday)
    final lastWeekStart = currentWeekStart.subtract(const Duration(days: 7));
    // Get the end of last week (Sunday)
    final lastWeekEnd = currentWeekStart.subtract(const Duration(days: 1));

    return (lastWeekStart, lastWeekEnd.add(const Duration(days: 1)));
  }
}
