import 'package:flutter/material.dart';
import 'package:practice/constants.dart';

class TopNav extends StatelessWidget {
  const TopNav({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: spacingThree,
          vertical: spacingFour,
        ),
        child: child);
  }
}
