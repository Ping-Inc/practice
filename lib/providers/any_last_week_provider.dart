import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'any_last_week_provider.g.dart';

@riverpod
Future<bool> anyLastWeek(Ref ref) async {
  return PingsRepository.anyLastWeek();
}
