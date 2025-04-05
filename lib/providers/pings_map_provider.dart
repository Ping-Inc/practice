import 'package:practice/data/ping_data.dart';
import 'package:practice/repositories/ping_repository.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pings_map_provider.g.dart';

@riverpod
class PingsMap extends _$PingsMap {
  @override
  Future<Map<int, PingData>> build() async {
    final pingsList = await PingsRepository.fetch();
    return {
      for (var ping in pingsList) ping['id'] as int: PingData.fromJson(ping)
    };
  }

  Future<void> addPing(String pingText, int? replyId) async {
    final now = DateTime.now();
    final id = replyId == null
        ? await PingsRepository.insert(pingText, now)
        : await PingsRepository.insertReply(pingText, replyId, now);

    final newPing = PingData(
      time: now,
      text: pingText,
      id: id,
      replyId: replyId,
      resonantCount: 0,
      resonantTime: null,
      viewCount: 0,
      hidden: false,
    );

    state = AsyncData({...state.value!, id: newPing});
  }

  Future<void> addAllPings(List<PingData> pings) async {
    final newMap = Map<int, PingData>.from(state.value!);
    for (var ping in pings) {
      try {
        final id = await PingsRepository.insert(ping.text, ping.time);
        final newPing = ping.copyWith(id: id);
        newMap[id] = newPing;
      } catch (e) {
        print('Error inserting ping: $e');
      }
    }
    state = AsyncData(newMap);
  }

  Future<void> updatePing(PingData ping) async {
    await PingsRepository.update(ping);
    state = AsyncData({...state.value!, ping.id!: ping});
  }

  Future<void> deletePing(int id) async {
    await PingsRepository.delete(id);
    final newMap = Map<int, PingData>.from(state.value!);
    newMap.remove(id);
    state = AsyncData(newMap);
  }

  Future<void> incrementResonance(int id) async {
    final ping = state.value![id];
    if (ping == null) return;

    await PingRepository.incrementResonantCount(id);
    final updatedPing = ping.copyWith(
      resonantCount: ping.resonantCount + 1,
      resonantTime: DateTime.now(),
    );
    state = AsyncData({...state.value!, id: updatedPing});
  }

  Future<void> toggleVisibility(int id) async {
    final ping = state.value![id];
    if (ping == null) return;

    await PingRepository.toggleVisibility(id, !ping.hidden);
    final updatedPing = ping.copyWith(hidden: !ping.hidden);
    state = AsyncData({...state.value!, id: updatedPing});
  }

  Future<void> incrementViewCount(int id) async {
    final ping = state.value![id];
    if (ping == null) return;

    await PingsRepository.incrementViewCount(id);
    final updatedPing = ping.copyWith(viewCount: ping.viewCount + 1);
    state = AsyncData({...state.value!, id: updatedPing});
  }
}
