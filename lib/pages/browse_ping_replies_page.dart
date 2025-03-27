import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/derived_pings_providers.dart';

class BrowsePingRepliesPage extends ConsumerWidget {
  const BrowsePingRepliesPage({super.key, required this.pingData});

  final PingData pingData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BrowsePage(pings: ref.watch(pingRepliesProvider(pingData.id!)));
  }
}
