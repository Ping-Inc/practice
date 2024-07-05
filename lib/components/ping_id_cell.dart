import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/providers/ping_id_provider.dart';

class PingIdCell extends ConsumerWidget {
  const PingIdCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (ref.watch(pingIdProvider)) {
      AsyncData(value: final id) => Text("P${id.toString()}",
          style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
      _ => Text("P")
    };
  }
}
