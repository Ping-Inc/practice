import 'package:practice/data/ping_data.dart';
import 'package:practice/providers/resonated_pings_count_provider.dart';
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
}
