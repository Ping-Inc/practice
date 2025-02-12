import 'package:flutter/material.dart';
import 'package:practice/enums/filters_enum.dart';
import 'package:practice/enums/time_filter_enum.dart';
import 'package:practice/extensions/date_time_extensions.dart';
import 'package:practice/pages/browse_all_page.dart';
import 'package:practice/pages/browse_hidden_page.dart';
import 'package:practice/pages/browse_last_week_page.dart';
import 'package:practice/pages/browse_mode_page.dart';
import 'package:practice/pages/browse_never_visited_page.dart';
import 'package:practice/pages/browse_replied_to_page.dart';
import 'package:practice/pages/browse_resonated_pings.dart';
import 'package:practice/pages/browse_time_page.dart';

extension StringParsing on FiltersEnum {
  String title() {
    switch (this) {
      case FiltersEnum.all_pings:
        return "all pings";
      case FiltersEnum.never_visited:
        return "never visited";
      case FiltersEnum.pings_with_replies:
        return "pings with replies";
      case FiltersEnum.resonated:
        return "re-pinged";
      case FiltersEnum.period_of_day:
        return "period of day";
      case FiltersEnum.day_of_week:
        return "day of week";
      case FiltersEnum.current_month:
        return "current month";
      case FiltersEnum.day_of_month:
        return "day of month";
      case FiltersEnum.year:
        return "current year";
      case FiltersEnum.one_week_old:
        return "one week old";
      case FiltersEnum.hidden:
        return "hidden";
    }
  }
}

extension WidgetParsing on FiltersEnum {
  Widget page(DateTime time) {
    switch (this) {
      case FiltersEnum.all_pings:
        return BrowseAllPage();
      case FiltersEnum.never_visited:
        return BrowseNeverVisitedPage();
      case FiltersEnum.pings_with_replies:
        return BrowseRepliedToPage();
      case FiltersEnum.resonated:
        return BrowseResonatedPingsPage();
      case FiltersEnum.period_of_day:
        return BrowseModePage(mode: time.themeMode());
      case FiltersEnum.day_of_week:
        return BrowseTimePage(time: time, timeEnum: TimeFilterEnum.dayOfWeek);
      case FiltersEnum.current_month:
        return BrowseTimePage(time: time, timeEnum: TimeFilterEnum.month);
      case FiltersEnum.day_of_month:
        return BrowseTimePage(time: time, timeEnum: TimeFilterEnum.dayOfMonth);
      case FiltersEnum.year:
        return BrowseTimePage(time: time, timeEnum: TimeFilterEnum.year);
      case FiltersEnum.one_week_old:
        return BrowseLastWeekPage();
      case FiltersEnum.hidden:
        return BrowseHiddenPage();
    }
  }
}
