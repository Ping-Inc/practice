enum FiltersEnum {
  hidden,
  one_week_old,
  day_of_week,
  period_of_day,
  resonated,
  placed,
  all_pings,
  saved_search,
}

class LensItem {
  final FiltersEnum filter;
  final String? savedSearchQuery;

  const LensItem.filter(this.filter) : savedSearchQuery = null;
  const LensItem.savedSearch(this.savedSearchQuery) : filter = FiltersEnum.saved_search;

  bool get isSavedSearch => filter == FiltersEnum.saved_search;
}
