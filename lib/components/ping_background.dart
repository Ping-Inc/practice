import 'package:flutter/material.dart';
import 'package:practice/constants.dart';

class PingBackground extends StatelessWidget {
  const PingBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: darkSecondary,
        borderRadius: BorderRadius.circular(spacingFour),
      ),
      child: child,
    );
  }
}
