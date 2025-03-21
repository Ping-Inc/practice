// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/constants.dart';
import 'package:practice/extensions/color_extensions.dart';
import 'package:practice/providers/base_color_provider.dart';

class Fade extends ConsumerWidget {
  const Fade({super.key, this.topDown = false});

  final bool topDown;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backgroundColor = ref.watch(baseColorProvider).background;

    return IgnorePointer(
        child: Align(
            alignment: topDown ? Alignment.topCenter : Alignment.bottomCenter,
            child: Container(
              height: fadeHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: topDown
                      ? [
                          backgroundColor.withOpacity(1.0),
                          backgroundColor.withOpacity(0.75),
                          backgroundColor.withOpacity(0.0),
                        ]
                      : [
                          backgroundColor.withOpacity(0.0),
                          backgroundColor.withOpacity(0.75),
                          backgroundColor.withOpacity(1.0),
                        ],
                ),
              ),
            )));
  }
}
