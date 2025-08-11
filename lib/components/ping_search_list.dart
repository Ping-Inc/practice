import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/ping_grid.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/providers/search_provider.dart';
import 'package:practice/providers/cached_search_provider.dart';
import 'package:practice/providers/cached_search_setting_provider.dart';

class PingSearchList extends ConsumerWidget {
  const PingSearchList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useCachedSearch = ref.watch(cachedSearchSettingProvider);
    
    final pings = useCachedSearch 
      ? ref.watch(cachedSearchProvider)
      : ref.watch(searchProvider);

    return switch (pings) {
      AsyncData(value: final pingsValue) => PingGrid(pings: pingsValue, shouldRetainScrollPosition: true),
      AsyncError() => SystemText(text: "Error"),
      _ => SizedBox.shrink()
    };
  }
}
