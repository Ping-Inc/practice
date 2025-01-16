import 'package:flutter/material.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/enums/text_size_enum.dart';

class PingCellNew extends StatelessWidget {
  const PingCellNew({super.key, required this.ping, this.onTap});

  final PingData ping;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SystemTap(
        child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(spacingFour),
            ),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: spacingFour, horizontal: spacingFive),
                      child: SystemText(
                        text: ping.text,
                        font: FontEnum.garamond,
                        size: TextSizeEnum.twentyNine,
                      )),
                ),
                Padding(
                    padding: EdgeInsets.all(spacingFive),
                    child:
                        SystemText(text: ping.id!.toString(), color: themeGray))
              ],
            )),
        onTap: onTap);
  }
}
