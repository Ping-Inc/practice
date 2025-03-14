import 'dart:async';
import 'package:practice/data/ping_data.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'last_week_pings_provider.g.dart';

@riverpod
class LastWeekPings extends _$LastWeekPings {
  @override
  Future<List<PingData>> build() async {
    final pingsList = await PingsRepository.fetchLastWeek();

    return pingsList.map<PingData>((data) => PingData.fromJson(data)).toList();
  }
}
