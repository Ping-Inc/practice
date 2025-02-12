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
import 'package:practice/utils/date_format_utils.dart';

class PingCell extends ConsumerWidget {
  const PingCell(
      {super.key,
      required this.inputPing,
      this.showDate = false,
      this.showId = false,
      this.tappable = true});

  final PingData inputPing;
  final bool showDate;
  final bool showId;
  final bool tappable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ping = ref.watch(pingProvider(inputPing));

    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (showDate)
        Padding(
            padding: EdgeInsets.only(bottom: spacingSmall),
            child: SystemText(text: DateFormatUtils.formatForPing(ping.time))),
      SystemTap(
          child: PingBackground(
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
                            ping.text,
                            style: TextStyle(
                                // height: lineHeight,
                                fontSize: TextSizeEnum.twentyNine.toFontSize(),
                                fontFamily: FontEnum.garamond.toFontFamily()),
                          )),
                    ),
                    if (showId)
                      SystemText(text: ping.id!.toString(), color: themeGray)
                  ]))),
          onTap: tappable
              ? () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsPage(ping: ping)),
                  )
              : null),
    ]);
  }
}
