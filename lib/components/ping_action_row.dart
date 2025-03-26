import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/hide_ping_button.dart';
import 'package:practice/components/reping_button.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_action_image.dart';
import 'package:practice/pages/new_ping_page.dart';

class PingActionRow extends ConsumerWidget {
  const PingActionRow({super.key, required this.ping});

  final PingData ping;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Expanded(flex: 1, child: Center(child: HidePingButton(ping: ping))),
      Expanded(flex: 1, child: Center(child: RepingButton(ping: ping))),
      Expanded(
          flex: 1,
          child: Center(
              child: SystemActionImage(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewPingPage(replyPing: ping)),
              );
            },
            imagePath: 'images/icons/reply.svg',
            text: 'reply',
            height: 18,
          ))),
    ]);
  }
}
