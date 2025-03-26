import 'package:flutter/material.dart';
import 'package:practice/enums/filters_enum.dart';
import 'package:practice/enums/time_filter_enum.dart';
import 'package:practice/extensions/date_time_extensions.dart';
import 'package:practice/extensions/day_of_week_enum_extensions.dart';
import 'package:practice/extensions/theme_mode_enum_extensions.dart';
import 'package:practice/pages/browse_all_page.dart';
import 'package:practice/pages/browse_hidden_page.dart';
import 'package:practice/pages/browse_last_week_page.dart';
import 'package:practice/pages/browse_mode_page.dart';
import 'package:practice/pages/browse_resonated_pings.dart';
import 'package:practice/pages/browse_time_page.dart';

extension StringParsing on FiltersEnum {
  String title(DateTime time) {
    switch (this) {
      case FiltersEnum.all_pings:
        return "all pings";
      case FiltersEnum.resonated:
        return "re-pings";
      case FiltersEnum.period_of_day:
        return "${time.themeMode().title()}s";
      case FiltersEnum.day_of_week:
        return "${time.dayOfWeek().title()}s";
      case FiltersEnum.one_week_old:
        return "last week";
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
      case FiltersEnum.resonated:
        return BrowseResonatedPingsPage();
      case FiltersEnum.period_of_day:
        return BrowseModePage(mode: time.themeMode());
      case FiltersEnum.day_of_week:
        return BrowseTimePage(time: time, timeEnum: TimeFilterEnum.dayOfWeek);
      case FiltersEnum.one_week_old:
        return BrowseLastWeekPage();
      case FiltersEnum.hidden:
        return BrowseHiddenPage();
    }
  }
}
