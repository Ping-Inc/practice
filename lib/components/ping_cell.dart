import 'package:flutter/material.dart';
import 'package:practice/components/ping_background.dart';
import 'package:practice/components/resonant_ping.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/pages/details_page.dart';

class PingCell extends StatelessWidget {
  const PingCell({super.key, required this.ping});

  final PingData ping;

  @override
  Widget build(BuildContext context) {
    return SystemTap(
        child: PingBackground(
            child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: spacingFour, vertical: spacingFour),
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
        )),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPage(ping: ping, title: "Home")),
          );
        });
  }
}
