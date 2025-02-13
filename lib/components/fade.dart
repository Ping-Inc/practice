// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:practice/constants.dart';

class Fade extends StatelessWidget {
  const Fade({super.key, this.topDown = false});

  final bool topDown;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
        child: Align(
            alignment: topDown ? Alignment.topCenter : Alignment.bottomCenter,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: topDown
                      ? [
                          themeUIBackgroundBlue.withOpacity(1.0),
                          themeUIBackgroundBlue.withOpacity(0.75),
                          themeUIBackgroundBlue.withOpacity(0.0),
                        ]
                      : [
                          themeUIBackgroundBlue.withOpacity(0.0),
                          themeUIBackgroundBlue.withOpacity(0.75),
                          themeUIBackgroundBlue.withOpacity(1.0),
                        ],
                ),
              ),
            )));
  }
}
