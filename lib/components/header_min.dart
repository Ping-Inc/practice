import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_button.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/text_size_enum.dart';

class HeaderMin extends StatelessWidget {
  const HeaderMin({super.key, this.title, this.subtitle});

  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(spacingFour),
        child: Stack(alignment: Alignment.center, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SystemButton(
              onTap: () => Navigator.pop(context),
              icon: PhosphorIcons.caret_left,
            ),
            if (subtitle != null)
              SystemText(
                text: subtitle!,
              )
          ]),
          if (title != null)
            Align(
                alignment: Alignment.center,
                child: SystemText(
                  text: title!,
                  size: TextSizeEnum.thirtySix,
                ))
        ]));
  }
}
