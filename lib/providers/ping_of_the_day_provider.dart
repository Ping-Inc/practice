import 'package:practice/data/ping.dart';
import 'package:practice/providers/current_day_of_month_provider.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ping_of_the_day_provider.g.dart';

@riverpod
Future<Ping> pingOfTheDay(PingOfTheDayRef ref) async {
  ref.watch(currentDayOfMonthProvider);

  final pingOfTheDay = await PingsRepository.random();

  return Ping.fromJson(pingOfTheDay);
}
