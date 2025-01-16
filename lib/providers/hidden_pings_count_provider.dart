import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hidden_pings_count_provider.g.dart';

@riverpod
Future<int> hiddenPingsCount(Ref ref) async {
  return await PingsRepository.countHidden();
}
