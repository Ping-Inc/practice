import 'dart:async';

import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'resonated_pings_count_provider.g.dart';

@riverpod
Future<int> resonatedPingsCount(ResonatedPingsCountRef ref) async {
  return await PingsRepository.countResonated();
}
