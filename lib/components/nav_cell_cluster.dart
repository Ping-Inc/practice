import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/ping_background.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/extensions/color_extensions.dart';
import 'package:practice/providers/base_color_provider.dart';

class NavCellCluster extends ConsumerWidget {
  const NavCellCluster({super.key, required this.text, required this.children});

  final String text;
  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SystemText(
          text: text,
          size: TextSizeEnum.twenty,
        ),
        SizedBox(
          height: spacingSmall,
        ),
        PingBackground(
            child: ListView.separated(
          padding: EdgeInsets.only(left: spacingXSmall),
          physics: NeverScrollableScrollPhysics(),
          primary: false,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return children[index];
          },
          separatorBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(left: spacingSmall),
              height: thinLine,
              color: ref.watch(baseColorProvider).secondary,
            );
          },
          itemCount: children.length,
        )),
      ],
    );
  }
}
