import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/enums/filters_enum.dart';
import 'package:practice/providers/any_last_week_provider.dart';
import 'package:practice/providers/any_resonated_provider.dart';
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

  final resonated = await ref.watch(anyResonatedProvider.future);
  final lastWeek = await ref.watch(anyLastWeekProvider.future);

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
