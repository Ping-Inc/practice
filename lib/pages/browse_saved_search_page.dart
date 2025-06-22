import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/pings_map_provider.dart';

class BrowseSavedSearchPage extends ConsumerWidget {
  const BrowseSavedSearchPage({
    super.key,
    required this.query,
  });

  final String query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pingsMapAsync = ref.watch(pingsMapProvider);
    
    return switch (pingsMapAsync) {
      AsyncData(value: final pingsMap) => () {
        final visiblePings = pingsMap.values.where((ping) => !ping.hidden);
        final filteredPings = visiblePings
            .where((ping) => ping.text.toLowerCase().contains(query.toLowerCase()))
            .toList()
          ..sort((a, b) => b.time.compareTo(a.time));
        
        return BrowsePage(pings: filteredPings);
      }(),
      AsyncError() => const BrowsePage(pings: []),
      _ => const BrowsePage(pings: []),
    };
  }
}
