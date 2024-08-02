import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/navigation_cell.dart';
import 'package:practice/pages/browse_replied_to_page.dart';
import 'package:practice/providers/pings_with_replies_count_provider.dart';

class PingsWithRepliesNavigationCell extends ConsumerWidget {
  const PingsWithRepliesNavigationCell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(pingsWithRepliesCountProvider);

    return switch (count) {
      AsyncData(value: final countValue) => NavigationCell(
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BrowseRepliedToPage()),
              ),
          label: "Pings with Replies",
          value: countValue.toString()),
      _ => SizedBox.shrink()
    };
  }
}
