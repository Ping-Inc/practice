import 'package:practice/data/ping_data.dart';
import 'package:practice/providers/hidden_pings_count_provider.dart';
import 'package:practice/providers/hidden_pings_provider.dart';
import 'package:practice/providers/last_week_pings_count_provider.dart';
import 'package:practice/providers/last_week_pings_provider.dart';
import 'package:practice/providers/never_visited_pings_provider.dart';
import 'package:practice/providers/ping_replies_provider.dart';
import 'package:practice/providers/pings_count_provider.dart';
import 'package:practice/providers/pings_provider.dart';
import 'package:practice/providers/pings_with_replies_count_provider.dart';
import 'package:practice/providers/replied_to_pings_provider.dart';
import 'package:practice/providers/replies_to_ping_count_provider.dart';
import 'package:practice/providers/resonated_pings_count_provider.dart';
import 'package:practice/providers/resonated_pings_provider.dart';
import 'package:practice/providers/unviewed_pings_count_provider.dart';
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

    ref.invalidate(resonatedPingsCountProvider);

    state = state.copyWith(resonantCount: state.resonantCount + 1);
  }

  Future<void> toggleVisibility() async {
    await PingRepository.toggleVisibility(state.id!, !state.hidden);

    ref.invalidate(pingsProvider);
    ref.invalidate(pingsCountProvider);

    ref.invalidate(repliedToPingsProvider);
    ref.invalidate(pingsWithRepliesCountProvider);

    ref.invalidate(neverVisitedPingsProvider);
    ref.invalidate(unviewedPingsCountProvider);

    ref.invalidate(resonatedPingsProvider);
    ref.invalidate(resonatedPingsCountProvider);

    // Invalid the time of day pings

    ref.invalidate(lastWeekPingsProvider);
    ref.invalidate(lastWeekPingsCountProvider);

    ref.invalidate(hiddenPingsProvider);
    ref.invalidate(hiddenPingsCountProvider);

    ref.invalidate(pingRepliesProvider(state.id!));
    ref.invalidate(repliesToPingCountProvider(state.id!));

    state = state.copyWith(hidden: !state.hidden);
  }
}
