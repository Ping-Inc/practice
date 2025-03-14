import 'package:practice/data/ping_data.dart';
import 'package:practice/providers/hidden_pings_provider.dart';
import 'package:practice/providers/last_week_pings_provider.dart';
import 'package:practice/providers/mode_filtered_pings_provider.dart';
import 'package:practice/providers/never_visited_pings_provider.dart';
import 'package:practice/providers/ping_replies_provider.dart';
import 'package:practice/providers/pings_provider.dart';
import 'package:practice/providers/replied_to_pings_provider.dart';
import 'package:practice/providers/resonated_pings_provider.dart';
import 'package:practice/providers/time_filtered_pings_provider.dart';
import 'package:practice/repositories/ping_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ping_provider.g.dart';

@riverpod
class Ping extends _$Ping {
  @override
  PingData build(PingData ping) {
    return ping;
  }

  Future<void> increaseResonance() async {
    await PingRepository.incrementResonantCount(state.id!);

    state = state.copyWith(
        resonantCount: state.resonantCount + 1, resonantTime: DateTime.now());
  }

  Future<void> toggleVisibility() async {
    await PingRepository.toggleVisibility(state.id!, !state.hidden);

    ref.invalidate(pingsProvider);

    ref.invalidate(repliedToPingsProvider);
    ref.invalidate(neverVisitedPingsProvider);
    ref.invalidate(resonatedPingsProvider);
    ref.invalidate(lastWeekPingsProvider);
    ref.invalidate(hiddenPingsProvider);
    ref.invalidate(pingRepliesProvider);
    ref.invalidate(modeFilteredPingsProvider);
    ref.invalidate(timeFilteredPingsProvider);

    state = state.copyWith(hidden: !state.hidden);
  }
}
