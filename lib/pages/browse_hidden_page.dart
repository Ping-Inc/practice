import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/derived_pings_providers.dart';

class BrowseHiddenPage extends ConsumerWidget {
  const BrowseHiddenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BrowsePage(pings: ref.watch(hiddenPingsProvider));
  }
}
