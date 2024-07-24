import 'package:flutter/material.dart';
import 'package:practice/constants.dart';

class TopNav extends StatelessWidget {
  const TopNav({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            left: spacingThree,
            right: spacingThree,
            bottom: spacingFour,
            top: spacingFour + MediaQuery.of(context).padding.top),
        child: child);
  }
}
