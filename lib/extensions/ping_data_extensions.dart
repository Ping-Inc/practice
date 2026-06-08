import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/utils/ping_export_renderer.dart';

extension PingDataSharing on PingData {
  String get formattedForSharing {
    final pingText = text.trim();
    final dayOfWeek = DateFormat('EEEE').format(time).toLowerCase();
    final month = DateFormat('MMMM').format(time).toLowerCase();
    final dayOfMonth = DateFormat('d').format(time);
    final year = DateFormat('yyyy').format(time);
    final timeFormatted = DateFormat('h:mm a').format(time).toLowerCase();
    final pingNumber = id;

    return '''
+-----------------+

$pingText

+-----------------+

#$pingNumber

date: $dayOfWeek, $month $dayOfMonth, $year
time: $timeFormatted''';
  }

  Future<void> export(
    BuildContext context, {
    required int latestPingId,
    required Color baseColor,
  }) async {
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    final Rect sharePositionOrigin = box != null
        ? box.localToGlobal(Offset.zero) & box.size
        : Rect.zero;

    if (kIsWeb) {
      await Share.share(
        formattedForSharing,
        sharePositionOrigin: sharePositionOrigin,
      );
      return;
    }

    File? pngFile;
    try {
      pngFile = await PingExportRenderer.renderToTempFile(
        context: context,
        ping: this,
        latestPingId: latestPingId,
        baseColor: baseColor,
      );

      await Share.shareXFiles(
        [XFile(pngFile.path)],
        text: formattedForSharing,
        sharePositionOrigin: sharePositionOrigin,
      );
    } catch (_) {
      await Share.share(
        formattedForSharing,
        sharePositionOrigin: sharePositionOrigin,
      );
    } finally {
      if (pngFile != null) {
        try {
          if (await pngFile.exists()) {
            await pngFile.delete();
          }
        } catch (_) {}
      }
    }
  }
}
