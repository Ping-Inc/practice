import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_button.dart';
import 'package:practice/pages/new_ping_page.dart';
import 'package:practice/providers/ping_provider.dart';

class PingActionRow extends ConsumerWidget {
  const PingActionRow({super.key, required this.ping});

  final PingData ping;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PingData reactivePing = ref.watch(pingProvider(ping));

    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: spacingFive, vertical: spacingTwo),
        child: Row(
          children: [
            Expanded(
                child: Row(
              children: [
                SystemButton(
                    onTap: () {
                      ref.read(pingProvider(ping).notifier).toggleVisibility();
                    },
                    icon: reactivePing.hidden
                        ? PhosphorIcons.eye
                        : PhosphorIcons.eye_closed,
                    text: reactivePing.hidden ? "Show" : "Hide"),
                SizedBox(
                  width: spacingThree,
                ),
                SystemButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewPingPage(replyPing: ping)),
                      );
                    },
                    icon: PhosphorIcons.arrow_arc_left,
                    text: "Reply"),
              ],
            )),
            SystemButton(
                onTap: () {
                  ref.read(pingProvider(ping).notifier).increaseResonance();
                },
                icon: PhosphorIcons.sparkle,
                text: reactivePing.resonantCount.toString()),
          ],
        ));
  }
}
