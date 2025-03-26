import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/providers/current_day_of_month_provider.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ping_of_the_day_provider.g.dart';

@riverpod
Future<PingData> pingOfTheDay(Ref ref) async {
  ref.watch(currentDayOfMonthProvider);

  final pingOfTheDay = await PingsRepository.random();

  return PingData.fromJson(pingOfTheDay);
}
