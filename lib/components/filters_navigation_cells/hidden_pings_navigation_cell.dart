import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/navigation_cell.dart';
import 'package:practice/pages/browse_all_page.dart';
import 'package:practice/providers/hidden_pings_count_provider.dart';

class HiddenPingsNavigationCell extends ConsumerWidget {
  const HiddenPingsNavigationCell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(hiddenPingsCountProvider);

    return switch (count) {
      AsyncData(value: final countValue) => NavigationCell(
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BrowseAllPage(count: countValue)),
              ),
          label: "Hidden",
          value: countValue.toString()),
      _ => SizedBox.shrink()
    };
  }
}
