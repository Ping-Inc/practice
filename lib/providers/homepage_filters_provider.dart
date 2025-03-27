import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/enums/filters_enum.dart';
import 'package:practice/providers/derived_pings_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'homepage_filters_provider.g.dart';

@riverpod
Future<List<FiltersEnum>> homepageFilters(Ref ref) async {
  final List<FiltersEnum> filters = [
    FiltersEnum.hidden,
    FiltersEnum.day_of_week,
    FiltersEnum.period_of_day,
    FiltersEnum.all_pings
  ];

  final resonated = ref.watch(anyResonatedProvider);
  final lastWeek = ref.watch(anyLastWeekProvider);

  if (resonated) {
    filters.add(FiltersEnum.resonated);
  }

  if (lastWeek) {
    filters.insert(
      1,
      FiltersEnum.one_week_old,
    );
  }

  return filters;
}
