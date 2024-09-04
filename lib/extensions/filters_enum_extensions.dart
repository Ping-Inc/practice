import 'package:flutter/material.dart';
import 'package:practice/enums/filters_enum.dart';
import 'package:practice/enums/time_filter_enum.dart';
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
        return "All Pings";
      case FiltersEnum.never_visited:
        return "Never Visited";
      case FiltersEnum.pings_with_replies:
        return "Pings With Replies";
      case FiltersEnum.resonated:
        return "Resonated";
      case FiltersEnum.period_of_day:
        return "Period of Day";
      case FiltersEnum.day_of_week:
        return "Day of Week";
      case FiltersEnum.current_month:
        return "Current Month";
      case FiltersEnum.day_of_month:
        return "Day of Month";
      case FiltersEnum.one_week_old:
        return "One Week Old";
      case FiltersEnum.hidden:
        return "Hidden";
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
        return BrowseModePage(time: time);
      case FiltersEnum.day_of_week:
        return BrowseTimePage(time: time, timeEnum: TimeFilterEnum.dayOfWeek);
      case FiltersEnum.current_month:
        return BrowseTimePage(time: time, timeEnum: TimeFilterEnum.month);
      case FiltersEnum.day_of_month:
        return BrowseTimePage(time: time, timeEnum: TimeFilterEnum.dayOfMonth);
      case FiltersEnum.one_week_old:
        return BrowseLastWeekPage();
      case FiltersEnum.hidden:
        return BrowseHiddenPage();
    }
  }
}
