import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/enums/lens_date.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/pings_map_provider.dart';

/// A lens that keeps the pings it had when it was opened.
///
/// Used by `hidden` and `public`, where the action you take (show, or making
/// a ping private) would otherwise remove the ping from the lens. Instead the
/// ping stays in place with its new look, so one tap undoes it. The list
/// refreshes the next time the lens is opened.
class BrowseSnapshotPage extends ConsumerStatefulWidget {
  const BrowseSnapshotPage({
    super.key,
    required this.pings,
    this.lensDate = LensDate.captured,
  });

  /// The lens's live list; read once, when the lens opens.
  final ProviderListenable<List<PingData>> pings;
  final LensDate lensDate;

  @override
  ConsumerState<BrowseSnapshotPage> createState() => _BrowseSnapshotPageState();
}

class _BrowseSnapshotPageState extends ConsumerState<BrowseSnapshotPage> {
  List<int>? _ids;
  LensDate? _lensDate;

  @override
  Widget build(BuildContext context) {
    final map = ref.watch(pingsMapProvider).valueOrNull;

    // Take the snapshot once the pings have loaded.
    if (_ids == null && map != null) {
      final pings = ref.read(widget.pings);
      _ids = [for (final ping in pings) ping.id!];
      // Keep dates (and so order) as they were, e.g. a ping made private
      // here keeps its "made public" date until the lens is reopened.
      _lensDate = widget.lensDate.frozenFor(pings);
    }

    // Cards still show each ping as it is now.
    final pings = [
      for (final id in _ids ?? const <int>[])
        if (map?[id] != null) map![id]!,
    ];

    return BrowsePage(pings: pings, lensDate: _lensDate ?? widget.lensDate);
  }
}
