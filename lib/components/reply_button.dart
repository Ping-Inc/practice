import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/providers/derived_pings_providers.dart' as derived;
import 'package:practice/providers/reply_on_provider.dart';

class ReplyButton extends ConsumerWidget {
  const ReplyButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestPing = ref.watch(derived.latestPingProvider);
    final replyOn = ref.watch(replyOnProvider);

    return latestPing == null
        ? SizedBox.shrink()
        : SystemTap(
            onTap: () => ref.read(replyOnProvider.notifier).toggle(),
            child: Container(
                padding: EdgeInsets.all(spacingFive),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(spacingFour),
                    color:
                        replyOn ? Theme.of(context).colorScheme.outline : null),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'images/icons/reply.svg',
                      height: 18,
                      colorFilter: ColorFilter.mode(
                          replyOn
                              ? Theme.of(context).colorScheme.surface
                              : Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn),
                    ),
                    SizedBox(
                      width: spacingFour,
                    ),
                    SystemText(
                        text: 'reply',
                        color: replyOn
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.primary)
                  ],
                )),
          );
  }
}
