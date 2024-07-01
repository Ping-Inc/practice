import 'dart:async';
import 'package:practice/data/ping.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pings_provider.g.dart';

@riverpod
class Pings extends _$Pings {
  @override
  Future<List<Ping>> build() async {
    final pingsList = await PingsRepository.fetch();

    return pingsList.map<Ping>((data) => Ping.fromJson(data)).toList();
  }

  Future<void> scroll() async {
    final pings = await future;

    if (pings.isNotEmpty) {
      final lastPing = pings.last;

      final pingsList = await PingsRepository.fetchBeforeTime(lastPing.time);

      final newPings =
          pingsList.map<Ping>((data) => Ping.fromJson(data)).toList();

      pings.addAll(newPings);

      state = AsyncData(pings);
    }
  }

  void addPing(String pingText) async {
    final ping = Ping(time: DateTime.now(), text: pingText);

    await PingsRepository.insert(ping);

    final pings = await future;

    pings.insert(0, ping);

    state = AsyncData(pings);
  }

  void addAllPings(List<Ping> pings) async {
    await PingsRepository.insertAll(pings);

    ref.invalidateSelf();
  }

  void deletePing(Ping ping) async {
    await PingsRepository.delete(ping.id!);

    final pings = await future;

    pings.remove(ping);

    state = AsyncData(pings);
  }
}
