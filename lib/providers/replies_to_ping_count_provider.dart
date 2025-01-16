import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/repositories/ping_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replies_to_ping_count_provider.g.dart';

@riverpod
Future<int> repliesToPingCount(Ref ref, int id) async {
  return await PingRepository.countReplies(id);
}
