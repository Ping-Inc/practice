import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/meta_data_text.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_divider.dart';
import 'package:practice/providers/latest_ping_provider.dart';
import 'package:practice/providers/reply_on_provider.dart';

class PingReplyText extends ConsumerWidget {
  const PingReplyText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestPing = ref.watch(latestPingProvider);
    final replyOn = ref.watch(replyOnProvider);

    if (replyOn) {
      return switch (latestPing) {
        AsyncData(value: final latestPing) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: spacingFive, vertical: spacingFour),
                  child: MetaDataText(text: "\"${latestPing!.text}\"")),
              SystemDivider()
            ],
          ),
        _ => SizedBox.shrink()
      };
    } else {
      return SizedBox.shrink();
    }
  }
}
