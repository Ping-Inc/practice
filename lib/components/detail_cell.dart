import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/extensions/color_extensions.dart';
import 'package:practice/providers/base_color_provider.dart';

class DetailCell extends ConsumerWidget {
  const DetailCell({super.key, required this.title, this.onClick});

  final String title;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SystemTap(
        onTap: onClick,
        child: Padding(
            padding: EdgeInsets.only(right: spacingFive),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SystemText(
                    text: title,
                    color: onClick == null
                        ? ref.watch(baseColorProvider).secondary
                        : ref.watch(baseColorProvider).primary),
              ],
            )));
  }
}
