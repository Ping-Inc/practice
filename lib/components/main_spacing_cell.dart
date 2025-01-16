import 'package:flutter/material.dart';
import 'package:practice/constants.dart';

class MainSpacingCell extends StatelessWidget {
  const MainSpacingCell(
      {super.key, required this.child, this.bottomPadding = false});

  final Widget child;
  final bool bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            left: spacingMedium,
            right: spacingMedium,
            bottom: bottomPadding ? spacingMedium : 0),
        child: child);
  }
}
