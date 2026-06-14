import 'dart:io';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gal/gal.dart';
import 'package:permission_handler/permission_handler.dart';
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
import 'package:practice/extensions/ping_data_extensions.dart';
import 'package:practice/extensions/text_size_enum_extensions.dart';
import 'package:practice/pages/new_ping_page.dart';
import 'package:practice/providers/base_color_provider.dart';
import 'package:practice/providers/derived_pings_providers.dart';
import 'package:practice/providers/ping_provider.dart';
import 'package:practice/providers/pings_map_provider.dart';
import 'package:practice/utils/ping_export_renderer.dart';

class PingContextMenu extends ConsumerStatefulWidget {
  const PingContextMenu({
    super.key,
    required this.pingData,
    required this.border,
  });

  final PingData pingData;
  final bool border;

  @override
  ConsumerState<PingContextMenu> createState() => _PingContextMenuState();
}

class _PingContextMenuState extends ConsumerState<PingContextMenu> {
  bool _saving = false;

  PingData get pingData => widget.pingData;
  bool get border => widget.border;

  Future<void> _exportText(BuildContext context) async {
    await pingData.export(context);
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _saveToPhotos(BuildContext context) async {
    if (_saving) return;
    _saving = true;

    final pingsMap = ref.read(pingsMapProvider).value;
    final latestPingId = (pingsMap == null || pingsMap.isEmpty)
        ? (pingData.id ?? 0)
        : pingsMap.keys.reduce((a, b) => a > b ? a : b);
    final baseColor = ref.read(baseColorProvider);

    File? pngFile;
    bool succeeded = false;
    try {
      pngFile = await PingExportRenderer.renderToTempFile(
        context: context,
        ping: pingData,
        latestPingId: latestPingId,
        baseColor: baseColor,
      );
      await Gal.putImage(pngFile.path);
      succeeded = true;
    } catch (_) {
      succeeded = false;
    } finally {
      if (pngFile != null) {
        try {
          if (await pngFile.exists()) {
            await pngFile.delete();
          }
        } catch (_) {}
      }
      _saving = false;
    }

    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    Navigator.of(context).pop();

    if (succeeded) {
      messenger.showSnackBar(
        SnackBar(
          elevation: 0,
          content: Text(
            'Ping saved to Photos',
            style: TextStyle(color: colorScheme.onSurface),
          ),
          backgroundColor: colorScheme.secondaryContainer,
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      messenger.showSnackBar(
        SnackBar(
          elevation: 0,
          content: Text.rich(
            TextSpan(
              style: TextStyle(color: colorScheme.onSurface),
              children: [
                const TextSpan(text: "Couldn't save Ping. Try checking "),
                TextSpan(
                  text: 'Settings',
                  style: const TextStyle(decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      messenger.hideCurrentSnackBar();
                      openAppSettings();
                    },
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
          backgroundColor: colorScheme.secondaryContainer,
          duration: const Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
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

  void _placeInCapture(BuildContext context) {
    Navigator.of(context).pop();

    if (pingData.id == null) return;

    ref.read(pingProvider(pingData).notifier).placeInCapture();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        content: GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewPingPage(),
              ),
            );
          },
          child: Text(
            'Ping placed in capture',
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _releaseFromCapture(BuildContext context) {
    Navigator.of(context).pop();

    ref.read(pingProvider(pingData).notifier).releaseFromCapture();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        content: Text(
          'Ping released from capture',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activePing = ref.watch(activePlacedPingProvider);
    final isCurrentlyInCapture = activePing?.id == pingData.id;

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
                      isCurrentlyInCapture: isCurrentlyInCapture,
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
                      crossAxisAlignment: CrossAxisAlignment.end,
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SystemActionImage(
                          onTap: () => _copyToClipboard(context),
                          imagePath: 'images/icons/copy.svg',
                          text: 'copy',
                          height: 18,
                        ),
                        SystemActionImage(
                          onTap: () => _exportText(context),
                          imagePath: 'images/icons/export.svg',
                          text: 'export',
                          height: 18,
                        ),
                        SystemActionImage(
                          onTap: () => isCurrentlyInCapture
                            ? _releaseFromCapture(context)
                            : _placeInCapture(context),
                          imagePath: isCurrentlyInCapture
                            ? 'images/icons/release.svg'
                            : 'images/icons/place.svg',
                          text: isCurrentlyInCapture ? 'release' : 'place',
                          height: 18,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spacingMedium),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: spacingMedium),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SystemActionImage(
                          onTap: () => _saveToPhotos(context),
                          imagePath: 'images/icons/save.svg',
                          text: 'save',
                          height: 18,
                        ),
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
