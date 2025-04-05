import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/providers/derived_pings_providers.dart';
import 'package:practice/providers/reply_on_provider.dart';
import 'package:practice/providers/time_provider.dart';

class PingReplyText extends ConsumerWidget {
  const PingReplyText({Key? key, this.replyPing}) : super(key: key);

  final PingData? replyPing;

  String _formatTimestamp(DateTime timestamp, DateTime now) {
    final difference = now.difference(timestamp).inDays;

    if (difference == 0) {
      return 'today, ${DateFormat('h:mm a').format(timestamp)}';
    } else {
      return '$difference days ago, ${DateFormat('h:mm a').format(timestamp)}';
    }
  }

  Widget pingReplyTextStatic(
      BuildContext context, PingData ping, DateTime now) {
    return Padding(
      padding: EdgeInsets.only(bottom: spacingThree),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SystemText(
                text: _formatTimestamp(ping.time, now).toLowerCase(),
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
          SizedBox(height: spacingTwo),
          SystemText(
            maxLines: 3,
            font: FontEnum.garamond,
            text: ping.text,
            size: TextSizeEnum.twenty,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = ref.watch(timeProvider).value ?? DateTime.now();
    if (replyPing != null) {
      return pingReplyTextStatic(context, replyPing!, now);
    } else {
      final latestPing = ref.watch(latestPingProvider);

      if (ref.watch(replyOnProvider)) {
        return Padding(
          padding: EdgeInsets.only(bottom: spacingThree),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SystemText(
                    text: _formatTimestamp(latestPing!.time, now).toLowerCase(),
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
              SizedBox(height: spacingTwo),
              SystemText(
                maxLines: 3,
                font: FontEnum.garamond,
                text: latestPing.text,
                size: TextSizeEnum.twenty,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        );
      } else {
        return SizedBox.shrink();
      }
    }
  }
}
