import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/meta_data_text.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/pages/pings_page.dart';
import 'package:practice/providers/current_ping_provider.dart';
import 'package:practice/providers/latest_ping_provider.dart';

class PingIdCell extends ConsumerWidget {
  const PingIdCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPing = ref.watch(currentPingProvider);

    return SystemTap(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PingsPage()),
          );
        },
        child: Row(children: [
          Container(
            height: 19,
            width: 19,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentPing.isEmpty
                    ? Colors.grey
                    : Theme.of(context).colorScheme.primary),
          ),
          SizedBox(width: spacingThree),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            MetaDataText(
                text: "p${switch (ref.watch(latestPingProvider)) {
              AsyncData(value: final latestPing) =>
                latestPing == null ? 1 : latestPing.id.toString(),
              _ => ""
            }}")
          ])
        ]));
  }
}
