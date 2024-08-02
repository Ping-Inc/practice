import 'package:flutter/material.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/text_size_enum.dart';

class PageWithHeader extends StatelessWidget {
  const PageWithHeader({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: EdgeInsets.all(spacingFour),
          child: SystemText(
            text: title,
            size: TextSizeEnum.thirtySix,
          )),
      child,
      SizedBox(
        height: spacingSeven,
      )
    ]);
  }
}
