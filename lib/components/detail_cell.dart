import 'package:flutter/material.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';

class DetailCell extends StatelessWidget {
  const DetailCell({super.key, required this.title, this.onClick});

  final String title;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: spacingFive),
        child: SystemTap(
            onTap: onClick,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SystemText(
                    text: title,
                    color: onClick == null
                        ? themeGray
                        : Theme.of(context).colorScheme.primary),
              ],
            )));
  }
}
