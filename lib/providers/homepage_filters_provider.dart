import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/enums/filters_enum.dart';
import 'package:practice/providers/app_mode_provider.dart';
import 'package:practice/providers/derived_pings_providers.dart';
import 'package:practice/providers/feature_flags_provider.dart';
import 'package:practice/providers/public_lens_open_provider.dart';
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
  // In public mode every lens already shows only public pings (and leaves
  // itself out when it has none). `hidden` and `public` don't apply, and
  // saved searches stay private since their titles could reveal what you
  // searched for.
  final isPublic = ref.watch(isPublicModeProvider);
  // Shown when any ping is public, and kept while you're in it even if you
  // make the last one private.
  final showPublic = !isPublic &&
      ref.watch(publicModeEnabledProvider) &&
      (ref.watch(anyPublicProvider) || ref.watch(publicLensOpenProvider));

  final List<LensItem> filters = [
    if (!isPublic) LensItem.filter(FiltersEnum.hidden),
    if (lastWeek) LensItem.filter(FiltersEnum.one_week_old),
    if (resonated) LensItem.filter(FiltersEnum.resonated),
    if (showPublic) LensItem.filter(FiltersEnum.public),
    if (historicalPlaced.isNotEmpty) LensItem.filter(FiltersEnum.placed),
    if (!isPublic) ...savedSearches.map((query) => LensItem.savedSearch(query)),
    if (onThisDay) LensItem.filter(FiltersEnum.on_this_day),
    LensItem.filter(FiltersEnum.all_pings),
  ];

  return filters;
}
