import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/design_system/system_loader.dart';
import 'package:practice/providers/pings_provider.dart';

class PingList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pings = ref.watch(pingsProvider);

    return switch (pings) {
      AsyncData(value: final pingsValue) => pingsValue.isEmpty
          ? Center(child: Text("No pings yet"))
          : ListView.builder(
              itemCount: pingsValue.length,
              itemBuilder: (context, index) {
                final ping = pingsValue[index];

                return Text(ping.text);
              },
            ),
      AsyncError() => Text("Error"),
      _ => SystemLoader()
    };
  }
}
