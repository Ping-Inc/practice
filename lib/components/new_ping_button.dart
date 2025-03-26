import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:practice/components/capture_button.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/providers/current_ping_provider.dart';
import 'package:practice/providers/latest_ping_provider.dart';
import 'package:practice/providers/ping_replies_provider.dart';
import 'package:practice/providers/pings_provider.dart';
import 'package:practice/providers/reply_on_provider.dart';

class NewPingButton extends ConsumerWidget {
  const NewPingButton(
      {super.key, required this.textEditingController, this.replyPing});

  final TextEditingController textEditingController;
  final PingData? replyPing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CaptureButton(
        disabled: ref.watch(currentPingProvider).isEmpty,
        onTap: () {
          ref.read(pingsProvider.notifier).addPing(
              textEditingController.text,
              replyPing == null
                  ? ref.read(replyOnProvider)
                      ? ref.read(latestPingProvider).value?.id
                      : null
                  : replyPing!.id);
          ref.read(currentPingProvider.notifier).reset();

          if (ref.read(replyOnProvider)) {
            ref.read(replyOnProvider.notifier).reset();
          }

          if (replyPing != null) {
            ref.invalidate(pingRepliesProvider(replyPing!.id!));
            context.pop();
          }
        });
  }
}
