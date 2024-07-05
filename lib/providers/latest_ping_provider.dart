import 'dart:async';

import 'package:practice/data/ping.dart';
import 'package:practice/providers/pings_provider.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'latest_ping_provider.g.dart';

@riverpod
Future<Ping?> latestPing(LatestPingRef ref) async {
  ref.watch(pingsProvider);

  final data = await PingsRepository.latest();

  if (data.isEmpty) {
    return null;
  } else {
    return Ping.fromJson(data.first);
  }
}
