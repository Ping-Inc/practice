import 'dart:async';
import 'package:practice/data/ping_data.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hidden_pings_provider.g.dart';

@riverpod
class HiddenPings extends _$HiddenPings {
  @override
  Future<List<PingData>> build() async {
    final pingsList = await PingsRepository.fetchHidden();

    return pingsList.map<PingData>((data) => PingData.fromJson(data)).toList();
  }
}
