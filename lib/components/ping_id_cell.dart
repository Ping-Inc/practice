import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/pages/pings_page.dart';
import 'package:practice/providers/latest_ping_provider.dart';
import 'package:practice/providers/ping_entry_color_provider.dart';

class PingIdCell extends ConsumerWidget {
  const PingIdCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(pingEntryColorProvider);

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
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          SizedBox(width: spacingThree),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SystemText(
                text: "p${switch (ref.watch(latestPingProvider)) {
                  AsyncData(value: final latestPing) =>
                    latestPing == null ? 1 : latestPing.id.toString(),
                  _ => ""
                }}",
                color: color,
                font: FontEnum.sfmono,
                size: TextSizeEnum.twelve)
          ])
        ]));
  }
}
