import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/filter_incrementer.dart';
import 'package:practice/extensions/theme_mode_enum_extensions.dart';
import 'package:practice/providers/mode_filter_increment_provider.dart';

class ModeFilterIncrementer extends ConsumerWidget {
  const ModeFilterIncrementer({super.key, required this.time});

  final DateTime time;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMode = ref.watch(modeFilterIncrementProvider(time));

    return FilterIncrementer(
      title: currentMode.toTitle(),
      increment: () {
        ref.read(modeFilterIncrementProvider(time).notifier).increment();
      },
      decrement: () {
        ref.read(modeFilterIncrementProvider(time).notifier).decrement();
      },
    );
  }
}
