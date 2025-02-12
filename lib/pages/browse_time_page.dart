import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/enums/time_filter_enum.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/time_filtered_pings_provider.dart';

class BrowseTimePage extends ConsumerWidget {
  const BrowseTimePage({super.key, required this.timeEnum, required this.time});

  final TimeFilterEnum timeEnum;
  final DateTime time;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BrowsePage(
        asyncPings: ref.watch(timeFilteredPingsProvider(timeEnum, time)),
        scroll: () => ref
            .read(timeFilteredPingsProvider(timeEnum, time).notifier)
            .scroll());
  }
}
