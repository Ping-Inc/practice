import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/text_size_enum.dart';

class FilterIncrementer extends ConsumerWidget {
  const FilterIncrementer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: spacingFour, horizontal: spacingFive),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SystemTap(child: Icon(PhosphorIcons.arrow_left_bold)),
            Expanded(
                child: SystemText(
              align: TextAlign.center,
              text: "Mondays",
              size: TextSizeEnum.thirtySix,
            )),
            SystemTap(child: Icon(PhosphorIcons.arrow_right_bold))
          ],
        ));
  }
}
