import 'dart:async';

import 'package:practice/providers/search_string_provider.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pings_count_provider.g.dart';

@riverpod
Future<int> pingsCount(PingsCountRef ref) async {
  ref.watch(searchStringProvider);

  return await PingsRepository.count();
}
