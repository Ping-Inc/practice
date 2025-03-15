import 'dart:async';

import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'any_resonated_provider.g.dart';

@riverpod
class AnyResonated extends _$AnyResonated {
  @override
  Future<bool> build() async {
    return PingsRepository.anyResonated();
  }

  Future<void> resonancePresent() async {
    state = AsyncData(true);
  }
}
