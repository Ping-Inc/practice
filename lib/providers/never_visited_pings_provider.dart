import 'dart:async';
import 'package:practice/data/ping_data.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'never_visited_pings_provider.g.dart';

@riverpod
class NeverVisitedPings extends _$NeverVisitedPings {
  @override
  Future<List<PingData>> build() async {
    final pingsList = await PingsRepository.fetchNeverVisited();

    return pingsList.map<PingData>((data) => PingData.fromJson(data)).toList();
  }
}
