import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_action_image.dart';
import 'package:practice/providers/pings_map_provider.dart';
import 'package:practice/providers/time_provider.dart';

class RepingButton extends ConsumerWidget {
  const RepingButton({super.key, required this.ping});

  final PingData ping;

  bool repingedRecently(PingData updatedPing, WidgetRef ref) {
    if (updatedPing.resonantTime == null) {
      return false;
    }

    ref.watch(timeProvider);
    final now = DateTime.now();
    final difference = now.difference(updatedPing.resonantTime!);
    return difference.inHours < 24;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updatedPing = ref.watch(pingsMapProvider).when(
          data: (map) => map[ping.id!] ?? ping,
          loading: () => ping,
          error: (_, __) => ping,
        );
    final isRepinged = repingedRecently(updatedPing, ref);

    return SystemActionImage(
      onTap: isRepinged
          ? () {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: Text('Already Re-Pinged'),
                  content: Text('You can re-ping this again tomorrow.'),
                  actions: [
                    CupertinoDialogAction(
                      child: Text('Okay'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              );
            }
          : () {
              ref.read(pingsMapProvider.notifier).incrementResonance(ping.id!);
            },
      color: isRepinged ? Theme.of(context).colorScheme.secondary : null,
      imagePath: 'images/icons/reping.svg',
      height: 22,
      text: isRepinged ? 're-pinged' : 're-ping',
    );
  }
}
