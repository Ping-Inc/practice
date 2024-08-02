import 'dart:async';
import 'package:practice/data/ping_data.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pings_provider.g.dart';

@riverpod
class Pings extends _$Pings {
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

  void addPing(String pingText, int? replyId) async {
    final now = DateTime.now();

    int id = replyId == null
        ? await PingsRepository.insert(pingText, now)
        : await PingsRepository.insertReply(pingText, replyId, now);

    final pings = await future;

    pings.insert(
        0,
        PingData(
            time: now,
            text: pingText,
            id: id,
            replyId: replyId,
            resonantCount: 0,
            viewCount: 0,
            hidden: false));

    state = AsyncData(pings);
  }

  void addAllPings(List<PingData> pings) async {
    await PingsRepository.insertAll(pings);

    ref.invalidateSelf();
  }

  void deletePing(PingData ping) async {
    await PingsRepository.delete(ping.id!);

    final pings = await future;

    pings.remove(ping);

    state = AsyncData(pings);
  }
}
