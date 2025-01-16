import 'package:flutter/material.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/text_size_enum.dart';

class DetailCellCluster extends StatelessWidget {
  const DetailCellCluster(
      {super.key,
      required this.title,
      required this.children,
      this.rightPadding = false});

  final String title;
  final List<Widget> children;
  final bool rightPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            top: spacingFive,
            bottom: spacingFive,
            right: rightPadding ? spacingFive : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SystemText(
              color: themePingIDInnerBlue,
              text: title,
              size: TextSizeEnum.fifteen,
            ),
            Row(children: children)
          ],
        ));
  }
}
