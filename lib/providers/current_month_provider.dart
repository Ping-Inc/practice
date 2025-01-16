import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/providers/time_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_month_provider.g.dart';

@riverpod
Future<DateTime> currentMonth(Ref ref) async {
  return ref.read(timeProvider).value ?? DateTime.now();
}
