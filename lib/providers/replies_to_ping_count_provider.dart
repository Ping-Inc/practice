import 'dart:async';

import 'package:practice/repositories/ping_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replies_to_ping_count_provider.g.dart';

@riverpod
Future<int> repliesToPingCount(RepliesToPingCountRef ref, int id) async {
  return await PingRepository.countReplies(id);
}
