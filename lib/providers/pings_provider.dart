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
            resonantTime: null,
            viewCount: 0,
            hidden: false));

    state = AsyncData(pings);
  }

  void addAllPings(List<PingData> pings) async {
    await PingsRepository.insertAll(pings);

    final originalPings = await future;

    originalPings.addAll(pings);

    state = AsyncData(originalPings);
  }

  void deletePing(PingData ping) async {
    await PingsRepository.delete(ping.id!);

    final pings = await future;

    pings.remove(ping);

    state = AsyncData(pings);
  }
}
