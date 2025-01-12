import 'package:flutter/material.dart';
import 'package:practice/constants.dart';

class MainSpacingCell extends StatelessWidget {
  const MainSpacingCell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: spacingMedium), child: child);
  }
}
