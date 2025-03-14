import 'dart:async';
import 'package:practice/data/ping_data.dart';
import 'package:practice/enums/theme_mode_enum.dart';
import 'package:practice/extensions/theme_mode_enum_extensions.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mode_filtered_pings_provider.g.dart';

@riverpod
class ModeFilteredPings extends _$ModeFilteredPings {
  @override
  Future<List<PingData>> build(ThemeModeEnum mode) async {
    final pingsList = await PingsRepository.fetchHourRange(
        mode.startingHour(), mode.endingHour());

    return pingsList.map<PingData>((data) => PingData.fromJson(data)).toList();
  }
}
