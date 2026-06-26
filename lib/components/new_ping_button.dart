import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gal/gal.dart';
import 'package:go_router/go_router.dart';
import 'package:practice/components/capture_button.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/providers/base_color_provider.dart';
import 'package:practice/providers/current_ping_provider.dart';
import 'package:practice/providers/derived_pings_providers.dart' as derived;
import 'package:practice/providers/photos_backup_on_provider.dart';
import 'package:practice/providers/pings_map_provider.dart';
import 'package:practice/providers/reply_on_provider.dart';
import 'package:practice/utils/ping_export_renderer.dart';

class NewPingButton extends ConsumerWidget {
  const NewPingButton(
      {super.key, required this.textEditingController, this.replyPing});

  final TextEditingController textEditingController;
  final PingData? replyPing;

  static Future<void> _autoSaveToPhotos(
    Future<PingData> pingFuture,
    OverlayState overlay,
    Color baseColor,
  ) async {
    File? file;
    try {
      final ping = await pingFuture;
      file = await PingExportRenderer.renderToTempFileFromOverlay(
        overlay: overlay,
        ping: ping,
        latestPingId: ping.id ?? 0,
        baseColor: baseColor,
      );
      await Gal.putImage(file.path);
    } catch (_) {
    } finally {
      if (file != null) {
        try {
          if (await file.exists()) await file.delete();
        } catch (_) {}
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CaptureButton(
        disabled: ref.watch(currentPingProvider).isEmpty,
        onTap: () {
          final overlay = Overlay.of(context);
          final pingText = textEditingController.text;
          final replyId = replyPing == null
              ? ref.read(replyOnProvider)
                  ? ref.read(derived.latestPingProvider)?.id
                  : null
              : replyPing!.id;
          final photosOn = ref.read(photosBackupOnProvider);
          final baseColor = ref.read(baseColorProvider);

          final pingFuture =
              ref.read(pingsMapProvider.notifier).addPing(pingText, replyId);

          ref.read(currentPingProvider.notifier).reset();

          if (ref.read(replyOnProvider)) {
            ref.read(replyOnProvider.notifier).reset();
          }

          if (replyPing != null) context.pop();

          if (photosOn) {
            unawaited(_autoSaveToPhotos(pingFuture, overlay, baseColor));
          }
        });
  }
}
