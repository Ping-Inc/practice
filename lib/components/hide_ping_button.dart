import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_action_icon.dart';
import 'package:practice/providers/ping_provider.dart';

class HidePingButton extends ConsumerWidget {
  const HidePingButton({super.key, required this.ping});

  final PingData ping;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PingData reactivePing = ref.watch(pingProvider(ping));

    return SystemActionIcon(
      onTap: () {
        ref.read(pingProvider(ping).notifier).toggleVisibility();
      },
      icon: reactivePing.hidden ? PhosphorIcons.eye : PhosphorIcons.eye_closed,
      text: reactivePing.hidden ? "show" : "hide",
    );
  }
}
