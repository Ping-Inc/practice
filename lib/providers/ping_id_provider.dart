import 'dart:async';

import 'package:practice/providers/pings_provider.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ping_id_provider.g.dart';

@riverpod
Future<int> pingId(PingIdRef ref) async {
  ref.watch(pingsProvider);

  return await PingsRepository.newestId();
}
