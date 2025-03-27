import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/text_size_enum.dart';

class DetailCellCluster extends ConsumerWidget {
  const DetailCellCluster(
      {super.key,
      required this.title,
      required this.children,
      this.rightPadding = false});

  final String title;
  final List<Widget> children;
  final bool rightPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: EdgeInsets.only(
            top: spacingFive,
            bottom: spacingFive,
            right: rightPadding ? spacingFive : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SystemText(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              text: title,
              size: TextSizeEnum.fifteen,
            ),
            Row(children: children)
          ],
        ));
  }
}
