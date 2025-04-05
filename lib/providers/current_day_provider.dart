import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/providers/time_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_day_provider.g.dart';

@riverpod
Future<DateTime> currentDay(Ref ref) async {
  // Set up a listener that only invalidates when the day of week changes
  ref.listen(timeProvider, (previous, next) {
    if (previous?.value?.day != next.value?.day) {
      ref.invalidateSelf();
    }
  });

  return DateTime.now();
}
