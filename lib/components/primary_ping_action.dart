import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/hide_ping_button.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_action_image.dart';
import 'package:practice/providers/feature_flags_provider.dart';
import 'package:practice/providers/ping_provider.dart';

/// The first action slot in focus view and Details.
///
/// Hidden → "show". Under 24 hours old → "hide". Otherwise → the "public"
/// toggle, whose icon shows whether the ping is public.
class PrimaryPingAction extends ConsumerWidget {
  const PrimaryPingAction({super.key, required this.ping});

  final PingData ping;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final publicModeEnabled = ref.watch(publicModeEnabledProvider);
    final reactivePing = ref.watch(pingProvider(ping));

    if (!publicModeEnabled ||
        reactivePing.hidden ||
        !reactivePing.canBePublic(DateTime.now())) {
      return HidePingButton(ping: ping);
    }

    final isPublic = reactivePing.isPublic;
    return Semantics(
      toggled: isPublic,
      child: SystemActionImage(
        onTap: () {
          final notifier = ref.read(pingProvider(ping).notifier);
          isPublic ? notifier.makePrivate() : notifier.makePublic();
        },
        height: 18,
        imagePath: isPublic
            ? 'images/icons/public_on.svg'
            : 'images/icons/public_off.svg',
        text: 'public',
      ),
    );
  }
}
