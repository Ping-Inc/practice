import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/constants.dart';
import 'package:practice/providers/time_provider.dart';

class PingBackground extends ConsumerWidget {
  const PingBackground({super.key, required this.child, this.time});

  final Widget child;
  final DateTime? time;

  Color calculateBackgroundColor() {
    if (time == null) {
      return themeCardBackgroundBlueOldest;
    }

    final now = DateTime.now();
    final difference = now.difference(time!).inMinutes;
    final totalMinutesIn24Hours = 24 * 60;

    if (difference >= totalMinutesIn24Hours) {
      return themeCardBackgroundBlueOldest;
    }

    final percentage = difference / totalMinutesIn24Hours;
    return Color.lerp(themeCardBackgroundBlueNewest,
        themeCardBackgroundBlueOldest, percentage)!;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (time != null) {
      ref.watch(timeProvider);
    }

    return Container(
      decoration: BoxDecoration(
        color: calculateBackgroundColor(),
        borderRadius: BorderRadius.circular(spacingFour),
      ),
      child: child,
    );
  }
}
