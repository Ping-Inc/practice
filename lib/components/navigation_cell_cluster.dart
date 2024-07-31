import 'package:flutter/material.dart';
import 'package:practice/components/ping_background.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_divider.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/text_size_enum.dart';

class NavigationCellCluster extends StatelessWidget {
  const NavigationCellCluster(
      {super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(spacingFour),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(
                    left: spacingFive, right: spacingFour, bottom: spacingFour),
                child: SystemText(
                  text: title.toUpperCase(),
                  size: TextSizeEnum.fifteen,
                )),
            PingBackground(
                child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: children.length,
              separatorBuilder: (context, index) => SystemDivider(),
              itemBuilder: (context, i) {
                return children[i];
              },
            ))
          ],
        ));
  }
}
