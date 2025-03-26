import 'dart:async';
import 'package:practice/data/ping_data.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'resonated_pings_provider.g.dart';

@riverpod
class ResonatedPings extends _$ResonatedPings {
  @override
  Future<List<PingData>> build() async {
    final pingsList = await PingsRepository.fetchResonated();

    return pingsList.map<PingData>((data) => PingData.fromJson(data)).toList();
  }

  Future<void> insert(PingData ping) async {
    final pings = await future;

    pings.removeWhere((existingPing) => existingPing.id == ping.id);
    pings.insert(0, ping);

    state = AsyncData(pings);
  }
}
