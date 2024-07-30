import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/providers/latest_ping_provider.dart';
import 'package:practice/providers/reply_on_provider.dart';

class ReplyPingButton extends ConsumerWidget {
  const ReplyPingButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestPing = ref.watch(latestPingProvider);
    final replyOn = ref.watch(replyOnProvider);

    return switch (latestPing) {
      AsyncData(value: final latestPing) => latestPing == null
          ? SizedBox(
              width: pingButtonWidth,
            )
          : SystemTap(
              onTap: () => ref.read(replyOnProvider.notifier).toggle(),
              child: SizedBox(
                height: pingButtonWidth,
                width: pingButtonWidth,
                child: Stack(
                  children: [
                    Container(
                      height: pingButtonWidth,
                      width: pingButtonWidth,
                      decoration: BoxDecoration(
                        color: replyOn ? Colors.grey : Colors.transparent,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Center(
                      child: Icon(PhosphorIcons.arrow_arc_left,
                          color: replyOn ? Colors.white : Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
      _ => SizedBox(width: 57)
    };
  }
}
