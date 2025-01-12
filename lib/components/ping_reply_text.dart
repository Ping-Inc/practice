import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/components/ping_reply_text_static.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/providers/latest_ping_provider.dart';
import 'package:practice/providers/reply_on_provider.dart';

class PingReplyText extends ConsumerWidget {
  const PingReplyText({Key? key, this.replyPing}) : super(key: key);

  final PingData? replyPing;

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp).inDays;

    if (difference == 0) {
      return 'today, ${DateFormat('h:mm a').format(timestamp)}';
    } else {
      return '$difference days ago, ${DateFormat('h:mm a').format(timestamp)}';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (replyPing != null) {
      return PingReplyTextStatic(ping: replyPing!);
    } else {
      final latestPing = ref.watch(latestPingProvider);
      final replyOn = ref.watch(replyOnProvider);

      if (replyOn) {
        return switch (latestPing) {
          AsyncData(value: final latestPing) => Padding(
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
                          text:
                              _formatTimestamp(latestPing!.time).toLowerCase(),
                          color: Theme.of(context).colorScheme.secondary)
                    ],
                  ),
                  SizedBox(height: spacingTwo),
                  SystemText(
                      font: FontEnum.garamond,
                      text: latestPing.text,
                      size: TextSizeEnum.twenty,
                      color: Theme.of(context).colorScheme.secondary)
                ],
              )),
          _ => SizedBox.shrink()
        };
      } else {
        return SizedBox.shrink();
      }
    }
  }
}
