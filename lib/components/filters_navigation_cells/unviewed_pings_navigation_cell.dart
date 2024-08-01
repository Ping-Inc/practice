import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/navigation_cell.dart';
import 'package:practice/pages/browse_all_page.dart';
import 'package:practice/providers/unviewed_pings_count_provider.dart';

class UnviewedPingsNavigationCell extends ConsumerWidget {
  const UnviewedPingsNavigationCell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(unviewedPingsCountProvider);

    return switch (count) {
      AsyncData(value: final countValue) => NavigationCell(
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BrowseAllPage(count: countValue)),
              ),
          label: "Never Visited",
          value: countValue.toString()),
      _ => SizedBox.shrink()
    };
  }
}
