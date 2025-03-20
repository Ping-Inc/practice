import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              hidden:
                  ref.watch(pingProvider(inputPing).select((p) => p.hidden)),
              time: ref
                  .watch(pingProvider(inputPing).select((p) => p.resonantTime)),
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: spacingFour, vertical: spacingFour),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: spacingXSmall,
                              right: spacingXSmall,
                              top: spacingXSmall),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: AutoSizeText(
                                  minFontSize: 1,
                                  inputPing.text,
                                  style: TextStyle(
                                      // height: lineHeight,
                                      fontSize:
                                          TextSizeEnum.twentyNine.toFontSize(),
                                      fontFamily:
                                          FontEnum.garamond.toFontFamily()),
                                )),
                                showId
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: spacingXSmall,
                                                    bottom: 4),
                                                child: SystemText(
                                                    align: TextAlign.center,
                                                    text: inputPing.id!
                                                        .toString(),
                                                    color: themeGray))
                                          ])
                                    : SizedBox(height: spacingXSmall)
                              ])),
                    ),
                  ]))),
          onLongPress: () {
            Clipboard.setData(ClipboardData(text: inputPing.text));

            // Show toast message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                elevation: 0,
                content: Text(
                  'Copied to clipboard',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: themeForegroundBlue,
                duration: Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
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
