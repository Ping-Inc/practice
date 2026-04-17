import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/enums/filters_enum.dart';
import 'package:practice/providers/derived_pings_providers.dart';
import 'package:practice/providers/simple_saved_searches_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'homepage_filters_provider.g.dart';

@riverpod
Future<List<LensItem>> homepageFilters(Ref ref) async {
  final resonated = ref.watch(anyResonatedProvider);
  final lastWeek = ref.watch(anyLastWeekProvider);
  final onThisDay = ref.watch(anyOnThisDayProvider);
  final historicalPlaced = ref.watch(historicalPlacedPingsProvider);
  final savedSearches = await ref.watch(simpleSavedSearchesProvider.future);

  final List<LensItem> filters = [
    LensItem.filter(FiltersEnum.hidden),
    if (lastWeek) LensItem.filter(FiltersEnum.one_week_old),
    if (resonated) LensItem.filter(FiltersEnum.resonated),
    if (historicalPlaced.isNotEmpty) LensItem.filter(FiltersEnum.placed),
    ...savedSearches.map((query) => LensItem.savedSearch(query)),
    if (onThisDay) LensItem.filter(FiltersEnum.on_this_day),
    LensItem.filter(FiltersEnum.all_pings),
  ];

  return filters;
}
