import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/ping_background.dart';
import 'package:practice/components/hide_ping_button.dart';
import 'package:practice/components/reping_button.dart';
import 'package:practice/components/reply_ping_button.dart';
import 'package:practice/design_system/system_action_image.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/extensions/font_enum_extensions.dart';
import 'package:practice/extensions/text_size_enum_extensions.dart';
import 'package:practice/providers/ping_provider.dart';
import 'package:practice/extensions/ping_data_extensions.dart';

class PingContextMenu extends ConsumerWidget {
  const PingContextMenu({
    super.key,
    required this.pingData,
    required this.border,
  });

  final PingData pingData;
  final bool border;

  void _shareText(BuildContext context) async {
  await pingData.share(context);
  Navigator.of(context).pop();
  }

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: pingData.text));
    
    Navigator.of(context).pop();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        content: Text(
          'Ping copied',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color.fromRGBO(217, 217, 217, 0.20),
          child: Column(
            children: [
              Spacer(flex: 2),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.width * 0.85,
                    child: PingBackground(
                      border: border,
                      hidden: ref.watch(pingProvider(pingData).select((p) => p.hidden)),
                      time: ref.watch(pingProvider(pingData).select((p) => p.resonantTime)),
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
                                      pingData.text,
                                      style: TextStyle(
                                        fontSize: TextSizeEnum.twentyNine.toFontSize(),
                                        fontFamily: FontEnum.garamond.toFontFamily(),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: spacingXSmall, bottom: 4),
                                        child: SystemText(
                                          align: TextAlign.center,
                                          text: pingData.id!.toString(),
                                          color: Theme.of(context).colorScheme.secondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  SizedBox(height: spacingMedium),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: spacingMedium),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        HidePingButton(ping: pingData),
                        RepingButton(ping: pingData),
                        ReplyPingButton(ping: pingData)
                      ],
                    ),
                  ),
                  SizedBox(height: spacingMedium),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: spacingMedium),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SystemActionImage(
                          onTap: () => _copyToClipboard(context),
                          imagePath: 'images/icons/copy.svg',
                          text: 'copy',
                          height: 18,
                        ),
                        SystemActionImage(
                          onTap: () => _shareText(context),
                          imagePath: 'images/icons/export.svg',
                          text: 'share',
                          height: 18,
                        ),
                        SizedBox(width: 48),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
