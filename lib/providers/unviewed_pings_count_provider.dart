import 'dart:async';

import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'unviewed_pings_count_provider.g.dart';

@riverpod
Future<int> unviewedPingsCount(UnviewedPingsCountRef ref) async {
  return await PingsRepository.countUnviewed();
}
