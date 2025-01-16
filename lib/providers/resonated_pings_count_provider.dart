import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'resonated_pings_count_provider.g.dart';

@riverpod
Future<int> resonatedPingsCount(Ref ref) async {
  return await PingsRepository.countResonated();
}
