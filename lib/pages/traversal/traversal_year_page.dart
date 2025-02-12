import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/design_system/system_loader.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/pages/traversal/traversal_year_page_post_fetch.dart';
import 'package:practice/providers/ping_years_provider.dart';

class TraversalYearPage extends ConsumerWidget {
  const TraversalYearPage({super.key, required this.year});

  final int year;

  Widget build(BuildContext context, WidgetRef ref) {
    return switch (ref.watch(pingYearsProvider)) {
      AsyncData(value: final pingYears) =>
        TraversalYearPagePostFetch(year: year, years: pingYears),
      AsyncError() => SliverToBoxAdapter(child: SystemText(text: "Error")),
      _ => SliverToBoxAdapter(child: SystemLoader())
    };
  }
}
