import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/navigation_cell.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/pings_count_provider.dart';
import 'package:practice/providers/pings_provider.dart';

class AllPingsNavigationCell extends ConsumerWidget {
  const AllPingsNavigationCell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(pingsCountProvider);
    final asyncPings = ref.watch(pingsProvider);

    return switch (count) {
      AsyncData(value: final countValue) => NavigationCell(
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BrowsePage(
                        title: "All Pings",
                        count: countValue,
                        asyncPings: asyncPings,
                        scroll: () =>
                            ref.read(pingsProvider.notifier).scroll())),
              ),
          label: "All Pings",
          value: countValue.toString()),
      _ => SizedBox.shrink()
    };
  }
}
