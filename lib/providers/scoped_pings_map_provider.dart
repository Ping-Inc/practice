import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/providers/app_mode_provider.dart';
import 'package:practice/providers/pings_map_provider.dart';

/// The pings the current mode may show: all of them in private mode, only
/// public (and not hidden) pings in public mode.
///
/// Lenses, grid, focus view, search and replies read through this, so public
/// mode can't show a private ping. Changing pings still goes through
/// [pingsMapProvider].
final scopedPingsMapProvider = Provider<AsyncValue<Map<int, PingData>>>((ref) {
  final pings = ref.watch(pingsMapProvider);
  if (!ref.watch(isPublicModeProvider)) return pings;

  return pings.whenData((map) => {
        for (final entry in map.entries)
          if (entry.value.isPublic && !entry.value.hidden)
            entry.key: entry.value,
      });
});
