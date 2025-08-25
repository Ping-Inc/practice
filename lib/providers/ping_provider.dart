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
    ref.read(pingsMapProvider.notifier).toggleVisibility(state.id!);
    state = state.copyWith(hidden: !state.hidden);
  }

  Future<void> placeInCapture() async {
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
      placedTime: null,
    );
    ref.read(pingsMapProvider.notifier).updatePing(updatedPing);
    state = updatedPing;
  }
}
