import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';
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
          ? SizedBox.shrink()
          : SystemTap(
              onTap: () => ref.read(replyOnProvider.notifier).toggle(),
              child: Container(
                  padding: EdgeInsets.all(spacingFive),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(spacingFour),
                      color: replyOn
                          ? Theme.of(context).colorScheme.surface
                          : null),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(PhosphorIcons.arrow_arc_right,
                          color: replyOn
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.primary),
                      SizedBox(
                        width: spacingFour,
                      ),
                      SystemText(
                          text: 'respond',
                          color: replyOn
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.primary)
                    ],
                  )),
            ),
      _ => SizedBox.shrink()
    };
  }
}
