import 'dart:async';
import 'package:practice/data/ping_data.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pings_filtered_by_month_provider.g.dart';

@riverpod
class PingsFilteredByMonthProvider extends _$PingsFilteredByMonthProvider {
  @override
  Future<List<PingData>> build() async {
    final pingsList = await PingsRepository.fetch();

    return pingsList.map<PingData>((data) => PingData.fromJson(data)).toList();
  }

  Future<void> scroll() async {
    final pings = await future;

    if (pings.isNotEmpty) {
      final lastPing = pings.last;

      final pingsList = await PingsRepository.fetchBeforeTime(lastPing.time);

      final newPings =
          pingsList.map<PingData>((data) => PingData.fromJson(data)).toList();

      pings.addAll(newPings);

      state = AsyncData(pings);
    }
  }
}
