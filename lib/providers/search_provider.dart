import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/providers/pings_map_provider.dart';
import 'package:practice/providers/search_string_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_provider.g.dart';

@riverpod
Future<List<PingData>> search(Ref ref) async {
  final searchString = ref.watch(searchStringProvider);

  if (searchString.isEmpty) {
    return [];
  }

  return ref.watch(pingsMapProvider).when(
        data: (map) {
          final visiblePings = map.values.where((ping) => !ping.hidden);
          return visiblePings
              .where((ping) =>
                  ping.text.toLowerCase().contains(searchString.toLowerCase()))
              .toList()
            ..sort((a, b) => b.time.compareTo(a.time));
        },
        loading: () => [],
        error: (_, __) => [],
      );
}
