import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ping_years_provider.g.dart';

@riverpod
Future<List<int>> pingYears(Ref ref) async {
  final years = await PingsRepository.fetchYears();

  return years.map((e) => int.parse(e['year'] as String)).toList();
}
