import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/last_week_pings_provider.dart';

class BrowseLastWeekPage extends ConsumerWidget {
  const BrowseLastWeekPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BrowsePage(asyncPings: ref.watch(lastWeekPingsProvider));
  }
}
