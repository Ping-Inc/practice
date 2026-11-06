import 'package:flutter/material.dart';
import 'package:practice/pages/browse_snapshot_page.dart';
import 'package:practice/providers/derived_pings_providers.dart';

class BrowseHiddenPage extends StatelessWidget {
  const BrowseHiddenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BrowseSnapshotPage(pings: hiddenPingsProvider);
  }
}
