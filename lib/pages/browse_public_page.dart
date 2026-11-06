import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/enums/lens_date.dart';
import 'package:practice/pages/browse_snapshot_page.dart';
import 'package:practice/providers/derived_pings_providers.dart';
import 'package:practice/providers/public_lens_open_provider.dart';

class BrowsePublicPage extends ConsumerStatefulWidget {
  const BrowsePublicPage({super.key});

  @override
  ConsumerState<BrowsePublicPage> createState() => _BrowsePublicPageState();
}

class _BrowsePublicPageState extends ConsumerState<BrowsePublicPage> {
  late final StateController<bool> _lensOpen;

  @override
  void initState() {
    super.initState();
    _lensOpen = ref.read(publicLensOpenProvider.notifier);
    // Providers can't be changed while the tree is building.
    WidgetsBinding.instance.addPostFrameCallback((_) => _lensOpen.state = true);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _lensOpen.state = false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BrowseSnapshotPage(
      pings: publicPingsProvider,
      lensDate: LensDate.madePublic,
    );
  }
}
