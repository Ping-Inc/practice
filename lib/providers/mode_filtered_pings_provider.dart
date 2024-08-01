import 'dart:async';
import 'package:practice/data/ping.dart';
import 'package:practice/extensions/theme_mode_enum_extensions.dart';
import 'package:practice/providers/mode_filter_increment_provider.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mode_filtered_pings_provider.g.dart';

@riverpod
class ModeFilteredPings extends _$ModeFilteredPings {
  @override
  Future<List<Ping>> build(DateTime time) async {
    final mode = ref.watch(modeFilterIncrementProvider(time));

    final pingsList = await PingsRepository.fetchHourRange(
        mode.startingHour(), mode.endingHour());

    return pingsList.map<Ping>((data) => Ping.fromJson(data)).toList();
  }

  Future<void> scroll() async {
    final mode = ref.read(modeFilterIncrementProvider(time));

    final pings = await future;

    if (pings.isNotEmpty) {
      final lastPing = pings.last;

      final pingsList = await PingsRepository.fetchHourRangeBeforeTime(
          lastPing.time, mode.startingHour(), mode.endingHour());

      final newPings =
          pingsList.map<Ping>((data) => Ping.fromJson(data)).toList();

      pings.addAll(newPings);

      state = AsyncData(pings);
    }
  }
}
