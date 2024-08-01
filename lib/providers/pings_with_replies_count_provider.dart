import 'dart:async';

import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pings_with_replies_count_provider.g.dart';

@riverpod
Future<int> pingsWithRepliesCount(PingsWithRepliesCountRef ref) async {
  return await PingsRepository.countReplies();
}
