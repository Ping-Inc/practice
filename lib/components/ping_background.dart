import 'package:flutter/material.dart';
import 'package:practice/constants.dart';

class PingBackground extends StatelessWidget {
  const PingBackground({super.key, required this.child, this.time});

  final Widget child;
  final DateTime? time;

  @override
  Widget build(BuildContext context) {
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

    return Container(
      decoration: BoxDecoration(
        color: calculateBackgroundColor(),
        borderRadius: BorderRadius.circular(spacingFour),
      ),
      child: child,
    );
  }
}
