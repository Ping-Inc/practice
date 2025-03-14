import 'dart:async';
import 'package:practice/data/ping_data.dart';
import 'package:practice/repositories/ping_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ping_replies_provider.g.dart';

@riverpod
class PingReplies extends _$PingReplies {
  @override
  Future<List<PingData>> build(int id) async {
    final pingsList = await PingRepository.fetchReplies(id);

    return pingsList.map<PingData>((data) => PingData.fromJson(data)).toList();
  }
}
