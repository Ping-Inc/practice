import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/constants.dart';
import 'package:practice/providers/time_provider.dart';

class PingBackground extends ConsumerWidget {
  const PingBackground(
      {super.key,
      required this.child,
      this.time,
      this.hidden = false,
      this.border = false});

  final Widget child;
  final DateTime? time;
  final bool hidden;
  final bool border;

  Color calculateBackgroundColor(WidgetRef ref, BuildContext context) {
    if (hidden) {
      return Colors.transparent;
    }

    if (time == null) {
      return Theme.of(context).colorScheme.surface;
    }

    final now = DateTime.now();
    final difference = now.difference(time!).inMinutes;
    final totalMinutesIn24Hours = 24 * 60;

    if (difference >= totalMinutesIn24Hours) {
      return Theme.of(context).colorScheme.surface;
    }

    ref.watch(timeProvider);

    final percentage = difference / totalMinutesIn24Hours;
    return Color.lerp(Theme.of(context).colorScheme.secondaryContainer,
        Theme.of(context).colorScheme.surface, percentage)!;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: calculateBackgroundColor(ref, context),
        borderRadius: BorderRadius.circular(spacingFour),
        border: hidden
            ? Border.all(
                color: Theme.of(context).colorScheme.primary, width: 0.5)
            : border
                ? Border.all(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    width: 1)
                : null,
      ),
      child: child,
    );
  }
}
