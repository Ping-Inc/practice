import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/ping_background.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/extensions/font_enum_extensions.dart';
import 'package:practice/extensions/text_size_enum_extensions.dart';
import 'package:practice/pages/details_page.dart';
import 'package:practice/providers/ping_provider.dart';

class PingCell extends ConsumerWidget {
  const PingCell(
      {super.key,
      required this.inputPing,
      this.showId = false,
      this.tappable = true});

  final PingData inputPing;
  final bool showId;
  final bool tappable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      SystemTap(
          child: PingBackground(
              time: ref
                  .watch(pingProvider(inputPing).select((p) => p.resonantTime)),
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: spacingFour, vertical: spacingFour),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Padding(
                          padding: EdgeInsets.all(spacingXSmall),
                          child: AutoSizeText(
                            minFontSize: 1,
                            inputPing.text,
                            style: TextStyle(
                                // height: lineHeight,
                                fontSize: TextSizeEnum.twentyNine.toFontSize(),
                                fontFamily: FontEnum.garamond.toFontFamily()),
                          )),
                    ),
                    if (showId)
                      SystemText(
                          text: inputPing.id!.toString(), color: themeGray)
                  ]))),
          onTap: tappable
              ? () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsPage(ping: inputPing)),
                  )
              : null),
    ]);
  }
}
