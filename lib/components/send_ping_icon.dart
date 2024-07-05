import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/constants.dart';
import 'package:practice/providers/current_ping_provider.dart';

class SendPingIcon extends ConsumerWidget {
  const SendPingIcon({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String ping = ref.watch(currentPingProvider);

    if (ping.isEmpty) {
      return SizedBox.shrink();
    } else {
      return IconButton(
          icon: Icon(
            PhosphorIcons.circle_fill,
            size: 24,
          ),
          color: gray2,
          onPressed: () => onPressed());
    }
  }
}
