import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_text.dart';

class PingReplyTextStatic extends ConsumerWidget {
  const PingReplyTextStatic({Key? key, required this.ping}) : super(key: key);

  final PingData ping;

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp).inDays;

    if (difference == 0) {
      return 'TODAY, ${DateFormat('h:mm a').format(timestamp)}';
    } else {
      return '$difference DAYS AGO, ${DateFormat('h:mm a').format(timestamp)}';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: EdgeInsets.only(
            left: spacingFive, right: spacingFive, bottom: spacingThree),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SystemText(
                    text: _formatTimestamp(ping.time),
                    color: Theme.of(context).colorScheme.secondary)
              ],
            ),
            SizedBox(height: spacingTwo),
            SystemText(
                text: ping.text, color: Theme.of(context).colorScheme.secondary)
          ],
        ));
  }
}
