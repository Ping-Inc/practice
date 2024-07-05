import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/providers/ping_id_provider.dart';

class PingIdCell extends ConsumerWidget {
  const PingIdCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
        "P${switch (ref.watch(pingIdProvider)) {
          AsyncData(value: final id) => id.toString(),
          _ => ""
        }}",
        style: TextStyle(color: Theme.of(context).colorScheme.secondary));
  }
}
