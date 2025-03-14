import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/pings_provider.dart';

class BrowseAllPage extends ConsumerWidget {
  const BrowseAllPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BrowsePage(asyncPings: ref.watch(pingsProvider));
  }
}
