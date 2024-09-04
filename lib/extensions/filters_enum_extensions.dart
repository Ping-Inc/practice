import 'package:flutter/material.dart';
import 'package:practice/enums/filters_enum.dart';
import 'package:practice/pages/browse_all_page.dart';
import 'package:practice/pages/browse_never_visited_page.dart';
import 'package:practice/pages/browse_replied_to_page.dart';
import 'package:practice/pages/browse_resonated_pings.dart';

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
    }
  }
}

extension WidgetParsing on FiltersEnum {
  Widget page() {
    switch (this) {
      case FiltersEnum.all_pings:
        return BrowseAllPage();
      case FiltersEnum.never_visited:
        return BrowseNeverVisitedPage();
      case FiltersEnum.pings_with_replies:
        return BrowseRepliedToPage();
      case FiltersEnum.resonated:
        return BrowseResonatedPingsPage();
    }
  }
}
