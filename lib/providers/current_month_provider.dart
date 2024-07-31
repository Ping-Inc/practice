import 'dart:async';

import 'package:practice/providers/time_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_month_provider.g.dart';

@riverpod
Future<DateTime> currentMonth(CurrentMonthRef ref) async {
  return ref.read(timeProvider).value ?? DateTime.now();
}
