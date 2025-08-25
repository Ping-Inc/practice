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
import 'package:practice/pages/browse_placed_pings.dart';
import 'package:practice/pages/browse_resonated_pings.dart';
import 'package:practice/pages/browse_time_page.dart';
import 'package:practice/pages/browse_saved_search_page.dart';

extension StringParsing on FiltersEnum {
  String title() {
    final time = DateTime.now();
    switch (this) {
      case FiltersEnum.hidden:
        return "hidden";
      case FiltersEnum.one_week_old:
        return "last week";
      case FiltersEnum.day_of_week:
        return "${time.dayOfWeek().title()}s";
      case FiltersEnum.period_of_day:
        return "${time.themeMode().title()}s";
      case FiltersEnum.resonated:
        return "re-pings";
      case FiltersEnum.placed:
        return "placed";
      case FiltersEnum.all_pings:
        return "all pings";
      case FiltersEnum.saved_search:
        return "saved search";
    }
  }
}

extension WidgetParsing on FiltersEnum {
  Widget page() {
    final time = DateTime.now();
    switch (this) {
      case FiltersEnum.hidden:
        return BrowseHiddenPage();
      case FiltersEnum.one_week_old:
        return BrowseLastWeekPage();
      case FiltersEnum.day_of_week:
        return BrowseTimePage(
          timeEnum: TimeFilterEnum.dayOfWeek,
          time: time,
        );
      case FiltersEnum.period_of_day:
        final mode = time.themeMode();
        return BrowseModePage(mode: mode.toString().split('.').last);
      case FiltersEnum.resonated:
        return BrowseResonatedPingsPage();
      case FiltersEnum.placed:
        return BrowsePlacedPingsPage();
      case FiltersEnum.all_pings:
        return BrowseAllPage();
      case FiltersEnum.saved_search:
        return Container();
    }
  }
}

extension LensItemExtensions on LensItem {
  String title() {
    if (isSavedSearch && savedSearchQuery != null) {
      return '"$savedSearchQuery"';
    }
    return filter.title();
  }

  Widget page() {
    if (isSavedSearch && savedSearchQuery != null) {
      return BrowseSavedSearchPage(query: savedSearchQuery!);
    }
    return filter.page();
  }
}
