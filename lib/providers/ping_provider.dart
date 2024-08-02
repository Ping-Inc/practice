import 'package:practice/data/ping_data.dart';
import 'package:practice/providers/hidden_pings_count_provider.dart';
import 'package:practice/providers/last_week_pings_count_provider.dart';
import 'package:practice/providers/pings_count_provider.dart';
import 'package:practice/providers/pings_provider.dart';
import 'package:practice/providers/pings_with_replies_count_provider.dart';
import 'package:practice/providers/resonated_pings_count_provider.dart';
import 'package:practice/providers/theme_mode_pings_count_provider.dart';
import 'package:practice/providers/time_of_day_pings_count_provider.dart';
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

    // TODO: Make sure all providers which depend on the visibility of this ping are invalidated
    ref.invalidate(pingsCountProvider);
    ref.invalidate(pingsProvider);

    ref.invalidate(pingsWithRepliesCountProvider);
    ref.invalidate(unviewedPingsCountProvider);
    ref.invalidate(resonatedPingsCountProvider);
    ref.invalidate(themeModePingsCountProvider);
    ref.invalidate(timeOfDayPingsCountProvider);

    ref.invalidate(lastWeekPingsCountProvider);
    ref.invalidate(hiddenPingsCountProvider);

    state = state.copyWith(hidden: !state.hidden);
  }
}
