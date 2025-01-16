import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/extensions/font_enum_extensions.dart';
import 'package:practice/extensions/text_size_enum_extensions.dart';

class PingCellNew extends StatelessWidget {
  const PingCellNew({super.key, required this.ping, this.onTap});

  final PingData ping;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SystemTap(
        child: Container(
            padding: EdgeInsets.all(spacingFive),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(spacingFour),
            ),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: AutoSizeText(
                    minFontSize: 1,
                    ping.text,
                    style: TextStyle(
                        // height: lineHeight,
                        fontSize: TextSizeEnum.twentyNine.toFontSize(),
                        fontFamily: FontEnum.garamond.toFontFamily()),
                  ),
                ),
                SystemText(text: ping.id!.toString(), color: themeGray)
              ],
            )),
        onTap: onTap);
  }
}
