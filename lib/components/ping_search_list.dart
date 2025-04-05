import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/ping_grid.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/providers/search_provider.dart';

class PingSearchList extends ConsumerWidget {
  const PingSearchList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pings = ref.watch(searchProvider);

    return switch (pings) {
      AsyncData(value: final pingsValue) => PingGrid(pings: pingsValue),
      AsyncError() => SystemText(text: "Error"),
      _ => SizedBox.shrink()
    };
  }
}
