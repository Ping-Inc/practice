import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/enums/time_filter_enum.dart';
import 'package:practice/providers/time_filter_increment_provider.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'time_of_day_pings_count_provider.g.dart';

@riverpod
Future<int> timeOfDayPingsCount(
    Ref ref, TimeFilterEnum timeFilter, DateTime currentTime) async {
  final time = ref.watch(timeFilterIncrementProvider(currentTime));

  switch (timeFilter) {
    case TimeFilterEnum.year:
      return await PingsRepository.countYear(time);
    case TimeFilterEnum.month:
      return await PingsRepository.countMonth(time);
    case TimeFilterEnum.dayOfMonth:
      return await PingsRepository.countDayOfMonth(time);
    case TimeFilterEnum.dayOfWeek:
      return await PingsRepository.countDayOfWeek(time);
  }
}
