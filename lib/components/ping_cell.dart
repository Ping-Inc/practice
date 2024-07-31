import 'package:flutter/material.dart';
import 'package:practice/components/resonant_ping.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/browse_enum.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/enums/text_size_enum.dart';

class PingCell extends StatelessWidget {
  const PingCell({super.key, required this.ping, required this.mode});

  final Ping ping;
  final BrowseEnum mode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: spacingFour, vertical: spacingFour),
      child: Row(children: [
        ResonantPing(ping: ping),
        SizedBox(
          width: spacingFive,
        ),
        Expanded(
            child: SystemText(
          text: ping.text,
          color: Theme.of(context).colorScheme.primary,
          font: FontEnum.garamond,
          size: TextSizeEnum.twenty,
        )),
      ]),
    );
  }
}
