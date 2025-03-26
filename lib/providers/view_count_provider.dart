import 'dart:async';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view_count_provider.g.dart';

@riverpod
class ViewCount extends _$ViewCount {
  @override
  Future<int> build(int pingId) async {
    final viewCount = await PingsRepository.viewCount(pingId);

    return viewCount;
  }

  Future<void> incrementViewCount() async {
    await PingsRepository.incrementViewCount(pingId);

    final viewcount = await future;

    state = AsyncData(viewcount + 1);
  }
}
