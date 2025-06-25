import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/ping_background.dart';
import 'package:practice/components/ping_context_menu.dart';
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
      this.tappable = true,
      this.border = false});

  final PingData inputPing;
  final bool tappable;
  final bool border;

  void _showContextMenu(BuildContext context) {
    
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      useSafeArea: false,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: PingContextMenu(
            pingData: inputPing,
            border: border,
          ),
        );
      },
    );

    HapticFeedback.mediumImpact();

  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      SystemTap(
          child: PingBackground(
              border: border,
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
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: spacingXSmall, bottom: 4),
                                          child: SystemText(
                                              align: TextAlign.center,
                                              text: inputPing.id!.toString(),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary))
                                    ])
                              ])),
                    ),
                  ]))),
          onLongPress: () => _showContextMenu(context),
          onTap: tappable
              ? () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailsPage(pingId: inputPing.id!)),
                  )
              : null),
    ]);
  }
}
