import 'dart:async';

import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pings_count_provider.g.dart';

@riverpod
Future<int> pingsCount(PingsCountRef ref) async {
  return await PingsRepository.count();
}
