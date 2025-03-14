import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/replied_to_pings_provider.dart';

class BrowseRepliedToPage extends ConsumerWidget {
  const BrowseRepliedToPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BrowsePage(asyncPings: ref.watch(repliedToPingsProvider));
  }
}
