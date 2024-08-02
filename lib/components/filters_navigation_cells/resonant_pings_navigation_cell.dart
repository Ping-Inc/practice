import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/navigation_cell.dart';
import 'package:practice/pages/browse_resonated_pings.dart';
import 'package:practice/providers/resonated_pings_count_provider.dart';

class ResonantPingsNavigationCell extends ConsumerWidget {
  const ResonantPingsNavigationCell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(resonatedPingsCountProvider);

    return switch (count) {
      AsyncData(value: final countValue) => NavigationCell(
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BrowseResonatedPingsPage()),
              ),
          label: "Resonated",
          value: countValue.toString()),
      _ => SizedBox.shrink()
    };
  }
}
