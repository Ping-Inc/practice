import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_action_image.dart';
import 'package:practice/providers/ping_provider.dart';

class HidePingButton extends ConsumerWidget {
  const HidePingButton({super.key, required this.ping});

  final PingData ping;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PingData reactivePing = ref.watch(pingProvider(ping));

    return SystemActionImage(
      onTap: () {
        ref.read(pingProvider(ping).notifier).toggleVisibility();
      },
      height: 18,
      imagePath: reactivePing.hidden
          ? 'images/icons/show.svg'
          : 'images/icons/hide.svg',
      text: reactivePing.hidden ? "show" : "hide",
    );
  }
}
