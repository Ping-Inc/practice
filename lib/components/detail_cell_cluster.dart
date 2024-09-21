import 'package:flutter/material.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/text_size_enum.dart';

class DetailCellCluster extends StatelessWidget {
  const DetailCellCluster(
      {super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: spacingFour,
          vertical: spacingFive,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SystemText(
              color: Theme.of(context).colorScheme.secondary,
              text: title.toUpperCase(),
              size: TextSizeEnum.fifteen,
            ),
            Row(children: children)
          ],
        ));
  }
}
