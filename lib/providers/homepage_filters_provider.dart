import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/enums/filters_enum.dart';
import 'package:practice/providers/derived_pings_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'homepage_filters_provider.g.dart';

@riverpod
Future<List<FiltersEnum>> homepageFilters(Ref ref) async {
  final resonated = ref.watch(anyResonatedProvider);
  final lastWeek = ref.watch(anyLastWeekProvider);

  final List<FiltersEnum> filters = [
    FiltersEnum.hidden,
    if (lastWeek) FiltersEnum.one_week_old,
    FiltersEnum.day_of_week,
    FiltersEnum.period_of_day,
    if (resonated) FiltersEnum.resonated,
    FiltersEnum.all_pings
  ];

  return filters;
}
