import 'dart:async';
import 'package:practice/data/ping_data.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replied_to_pings_provider.g.dart';

@riverpod
class RepliedToPings extends _$RepliedToPings {
  @override
  Future<List<PingData>> build() async {
    final pingsList = await PingsRepository.fetchReplies();

    return pingsList.map<PingData>((data) => PingData.fromJson(data)).toList();
  }
}
