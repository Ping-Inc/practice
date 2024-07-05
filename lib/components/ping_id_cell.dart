import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/providers/latest_ping_provider.dart';

class PingIdCell extends ConsumerWidget {
  const PingIdCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
        "P${switch (ref.watch(latestPingProvider)) {
          AsyncData(value: final latestPing) =>
            latestPing == null ? 1 : latestPing.id.toString(),
          _ => ""
        }}",
        style: TextStyle(color: Theme.of(context).colorScheme.secondary));
  }
}
