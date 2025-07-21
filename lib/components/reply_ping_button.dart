import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_action_image.dart';
import 'package:practice/pages/new_ping_page.dart';

class ReplyPingButton extends ConsumerWidget {
  const ReplyPingButton({super.key, required this.ping});

  final PingData ping;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SystemActionImage(
      onTap: () {
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewPingPage(replyPing: ping),
          ),
        );
      },
      imagePath: 'images/icons/reply.svg',
      text: 'reply',
      height: 18,
    );
  }
}
