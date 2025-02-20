import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_action_image.dart';
import 'package:practice/providers/ping_provider.dart';
import 'package:practice/providers/repinged_count_provider.dart';
import 'package:practice/providers/resonated_pings_provider.dart';

class RepingButton extends ConsumerWidget {
  const RepingButton({super.key, required this.ping});

  final PingData ping;

  bool repingedRecently(PingData updatedPing) {
    if (updatedPing.resonantTime == null) {
      return false;
    }
    final now = DateTime.now();
    final difference = now.difference(updatedPing.resonantTime!);
    return difference.inHours < 24;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRepinged = repingedRecently(ref.watch(pingProvider(ping)));

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
              ref.read(pingProvider(ping).notifier).increaseResonance();
              ref.invalidate(resonatedPingsProvider);
              ref.invalidate(repingedCountProvider(ping.id!));
            },
      color: isRepinged ? themeGray : null,
      imagePath: 'images/icons/reping.svg',
      height: 22,
      text: isRepinged ? 're-pinged' : 're-ping',
    );
  }
}
