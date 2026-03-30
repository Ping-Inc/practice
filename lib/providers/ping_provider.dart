import 'package:practice/data/ping_data.dart';
import 'package:practice/providers/pings_map_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ping_provider.g.dart';

@riverpod
class Ping extends _$Ping {
  @override
  PingData build(PingData ping) {
    return ping;
  }

  Future<void> increaseResonance() async {
    ref.read(pingsMapProvider.notifier).incrementResonance(state.id!);
    state = state.copyWith(
        resonantCount: state.resonantCount + 1, resonantTime: DateTime.now());
  }

  Future<void> toggleVisibility() async {
    await ref.read(pingsMapProvider.notifier).toggleVisibility(state.id!);
    state = state.copyWith(hidden: !state.hidden);
  }

  Future<void> placeInCapture() async {
    // TODO: Remove this once internal users have installed this build and called this method.
    // It shouldn't be necessary to "release" all other pings here, and it's arguably a shady practice.
    // But, we need to clear out any pings that were placed before the new system was implemented.
    final allPingsAsync = ref.read(pingsMapProvider);

    allPingsAsync.whenData((map) {
      for (final ping in map.values) {
        if (ping.isPlaced) {
          ref.read(pingsMapProvider.notifier).updatePing(
            ping.copyWith(isPlaced: false),
          );
        }
      }
    });

    final updatedPing = state.copyWith(
      isPlaced: true,
      placedTime: DateTime.now(),
    );
    ref.read(pingsMapProvider.notifier).updatePing(updatedPing);
    state = updatedPing;
  }

  Future<void> releaseFromCapture() async {
    final updatedPing = state.copyWith(
      isPlaced: false,
      // placedTime stays the same for historical record
    );
    ref.read(pingsMapProvider.notifier).updatePing(updatedPing);
    state = updatedPing;
  }
}
