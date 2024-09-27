import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';

class DetailCell extends StatelessWidget {
  const DetailCell({super.key, required this.title, required this.onClick});

  final String title;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: spacingFive),
        child: SystemTap(
            onTap: onClick,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SystemText(text: title),
                SizedBox(width: spacingTwo),
                Icon(
                  PhosphorIcons.caret_right,
                  size: 16,
                )
              ],
            )));
  }
}
