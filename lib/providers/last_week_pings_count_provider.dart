import 'dart:async';

import 'package:practice/providers/current_week_provider.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'last_week_pings_count_provider.g.dart';

@riverpod
Future<int> lastWeekPingsCount(LastWeekPingsCountRef ref) async {
  ref.watch(currentWeekProvider);

  return await PingsRepository.countLastWeek();
}
