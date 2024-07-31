import 'dart:async';

import 'package:practice/providers/time_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_year_provider.g.dart';

@riverpod
Future<DateTime> currentYear(CurrentYearRef ref) async {
  return ref.read(timeProvider).value ?? DateTime.now();
}
