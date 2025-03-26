import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/constants.dart';
import 'package:practice/extensions/color_extensions.dart';
import 'package:practice/providers/base_color_provider.dart';
import 'package:practice/providers/time_provider.dart';

class PingBackground extends ConsumerWidget {
  const PingBackground(
      {super.key, required this.child, this.time, this.hidden = false});

  final Widget child;
  final DateTime? time;
  final bool hidden;

  Color calculateBackgroundColor(WidgetRef ref) {
    if (hidden) {
      return Colors.transparent;
    }

    if (time == null) {
      return ref.watch(baseColorProvider).ping;
    }

    final now = DateTime.now();
    final difference = now.difference(time!).inMinutes;
    final totalMinutesIn24Hours = 24 * 60;

    if (difference >= totalMinutesIn24Hours) {
      return ref.watch(baseColorProvider).ping;
    }

    ref.watch(timeProvider);

    final percentage = difference / totalMinutesIn24Hours;
    return Color.lerp(ref.watch(baseColorProvider).pingResonant,
        ref.watch(baseColorProvider).ping, percentage)!;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: calculateBackgroundColor(ref),
        borderRadius: BorderRadius.circular(spacingFour),
        border: hidden
            ? Border.all(
                color: Theme.of(context).colorScheme.primary, width: 0.5)
            : null,
      ),
      child: child,
    );
  }
}
