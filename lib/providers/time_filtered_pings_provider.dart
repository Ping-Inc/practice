import 'dart:async';
import 'package:practice/data/ping_data.dart';
import 'package:practice/enums/time_filter_enum.dart';
import 'package:practice/providers/time_filter_increment_provider.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'time_filtered_pings_provider.g.dart';

@riverpod
class TimeFilteredPings extends _$TimeFilteredPings {
  @override
  Future<List<PingData>> build(
      TimeFilterEnum timeFilter, DateTime currentTime) async {
    final time = ref.watch(timeFilterIncrementProvider(currentTime));

    late final pingsList;

    switch (timeFilter) {
      case TimeFilterEnum.year:
        pingsList = await PingsRepository.fetchYear(time);
        break;
      case TimeFilterEnum.month:
        pingsList = await PingsRepository.fetchMonth(time);
        break;
      case TimeFilterEnum.dayOfWeek:
        pingsList = await PingsRepository.fetchDayOfWeek(time);
        break;
      case TimeFilterEnum.dayOfMonth:
        pingsList = await PingsRepository.fetchDayOfMonth(time);
        break;
    }

    return pingsList.map<PingData>((data) => PingData.fromJson(data)).toList();
  }

  Future<void> scroll() async {
    final time = ref.read(timeFilterIncrementProvider(currentTime));

    final pings = await future;

    if (pings.isNotEmpty) {
      final lastPing = pings.last;

      late final pingsList;

      switch (timeFilter) {
        case TimeFilterEnum.year:
          pingsList =
              await PingsRepository.fetchYearBeforeTime(lastPing.time, time);
          break;
        case TimeFilterEnum.month:
          pingsList =
              await PingsRepository.fetchMonthBeforeTime(lastPing.time, time);
          break;
        case TimeFilterEnum.dayOfWeek:
          pingsList = await PingsRepository.fetchDayOfWeekBeforeTime(
              lastPing.time, time);
          break;
        case TimeFilterEnum.dayOfMonth:
          pingsList = await PingsRepository.fetchDayOfMonthBeforeTime(
              lastPing.time, time);
          break;
      }

      final newPings =
          pingsList.map<PingData>((data) => PingData.fromJson(data)).toList();

      pings.addAll(newPings);

      state = AsyncData(pings);
    }
  }
}
