import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/providers/time_provider.dart';

class CurrentTime {
  final DateTime now;
  final DateTime today;
  final DateTime yesterday;
  final DateTime startOfYear;

  CurrentTime(this.now)
      : today = DateTime(now.year, now.month, now.day),
        yesterday = DateTime(now.year, now.month, now.day)
            .subtract(const Duration(days: 1)),
        startOfYear = DateTime(now.year);

  DateTime get startOfWeek => today.subtract(Duration(days: now.weekday - 1));
}

final currentTimeProvider = Provider<CurrentTime>((ref) {
  final now = ref.watch(timeProvider).value ?? DateTime.now();
  return CurrentTime(now);
});
