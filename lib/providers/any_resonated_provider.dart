import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'any_resonated_provider.g.dart';

@riverpod
Future<bool> anyResonated(Ref ref) async {
  return PingsRepository.anyResonated();
}
