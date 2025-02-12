import 'dart:async';
import 'package:practice/data/ping_data.dart';
import 'package:practice/enums/time_filter_enum.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'time_filtered_pings_provider.g.dart';

@riverpod
class TimeFilteredPings extends _$TimeFilteredPings {
  @override
  Future<List<PingData>> build(
      TimeFilterEnum timeFilter, DateTime currentTime) async {
    late final pingsList;

    switch (timeFilter) {
      case TimeFilterEnum.year:
        pingsList = await PingsRepository.fetchYear(currentTime);
        break;
      case TimeFilterEnum.month:
        pingsList = await PingsRepository.fetchMonth(currentTime);
        break;
      case TimeFilterEnum.dayOfWeek:
        pingsList = await PingsRepository.fetchDayOfWeek(currentTime);
        break;
      case TimeFilterEnum.dayOfMonth:
        pingsList = await PingsRepository.fetchDayOfMonth(currentTime);
        break;
    }

    return pingsList.map<PingData>((data) => PingData.fromJson(data)).toList();
  }

  Future<void> scroll() async {
    final pings = await future;

    if (pings.isNotEmpty) {
      final lastPing = pings.last;

      late final pingsList;

      switch (timeFilter) {
        case TimeFilterEnum.year:
          pingsList = await PingsRepository.fetchYearBeforeTime(
              lastPing.time, currentTime);
          break;
        case TimeFilterEnum.month:
          pingsList = await PingsRepository.fetchMonthBeforeTime(
              lastPing.time, currentTime);
          break;
        case TimeFilterEnum.dayOfWeek:
          pingsList = await PingsRepository.fetchDayOfWeekBeforeTime(
              lastPing.time, currentTime);
          break;
        case TimeFilterEnum.dayOfMonth:
          pingsList = await PingsRepository.fetchDayOfMonthBeforeTime(
              lastPing.time, currentTime);
          break;
      }

      final newPings =
          pingsList.map<PingData>((data) => PingData.fromJson(data)).toList();

      pings.addAll(newPings);

      state = AsyncData(pings);
    }
  }
}
