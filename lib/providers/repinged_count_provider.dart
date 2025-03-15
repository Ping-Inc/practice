import 'dart:async';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repinged_count_provider.g.dart';

@riverpod
class RepingedCount extends _$RepingedCount {
  @override
  Future<int> build(int pingId) async {
    final repingedCount = await PingsRepository.repingedCount(pingId);

    return repingedCount;
  }

  Future<void> increment() async {
    final repingedCount = await PingsRepository.repingedCount(pingId);

    state = AsyncData(repingedCount + 1);
  }
}
