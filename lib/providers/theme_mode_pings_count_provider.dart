import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/extensions/theme_mode_enum_extensions.dart';
import 'package:practice/providers/mode_filter_increment_provider.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_mode_pings_count_provider.g.dart';

@riverpod
Future<int> themeModePingsCount(Ref ref, DateTime time) async {
  final mode = ref.watch(modeFilterIncrementProvider(time));

  return await PingsRepository.countHourRangeBeforeTime(
      mode.startingHour(), mode.endingHour());
}
