import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/import_pings_button.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_loader.dart';
import 'package:practice/providers/pings_provider.dart';

class PingList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pings = ref.watch(pingsProvider);

    return switch (pings) {
      AsyncData(value: final pingsValue) => pingsValue.isEmpty
          ? Center(
              child:
                  Column(children: [Text("No pings yet"), ImportPingsButton()]))
          : ListView.builder(
              itemCount: pingsValue.length,
              itemBuilder: (context, i) {
                final ping = pingsValue[i];

                if (i == pingsValue.length - 1 &&
                    pingsValue.length % fetchLimit == 0) {
                  ref.read(pingsProvider.notifier).scroll();
                }

                if (i == pingsValue.length - 1) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(ping.text), ImportPingsButton()],
                  );
                } else {
                  return Text(ping.text);
                }
              },
            ),
      AsyncError() => Text("Error"),
      _ => SystemLoader()
    };
  }
}
