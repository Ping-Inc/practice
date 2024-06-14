import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/components/import_pings_button.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping.dart';
import 'package:practice/design_system/system_loader.dart';
import 'package:practice/providers/pings_provider.dart';

class PingList extends ConsumerWidget {
  Widget pingCell(BuildContext context, Ping ping) {
    return Padding(
        padding: EdgeInsets.only(
            left: spacingTwo, bottom: spacingThree, right: spacingTwo),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(ping.text),
          Text(DateFormat('h:mm a - EEEE MMMM d, y').format(ping.time),
              style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
        ]));
  }

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
                    children: [pingCell(context, ping), ImportPingsButton()],
                  );
                } else {
                  return pingCell(context, ping);
                }
              },
            ),
      AsyncError() => Text("Error"),
      _ => SystemLoader()
    };
  }
}
