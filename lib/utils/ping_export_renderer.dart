import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:practice/components/export_ping_card.dart';
import 'package:practice/data/ping_data.dart';

class PingExportRenderer {
  PingExportRenderer._();

  static const double _pixelRatio = 3.0;

  static Future<File> renderToTempFile({
    required BuildContext context,
    required PingData ping,
    required int latestPingId,
    required Color baseColor,
  }) async {
    final widget = ExportPingCard(
      ping: ping,
      latestPingId: latestPingId,
      baseColor: baseColor,
    );

    final bytes = await _renderWidgetToPngBytes(
      context: context,
      widget: widget,
      logicalSize: const Size(ExportPingCard.width, ExportPingCard.height),
    );

    final tempDir = await getTemporaryDirectory();
    final file = File(p.join(tempDir.path, 'ping_${ping.id}.png'));
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  static Future<Uint8List> _renderWidgetToPngBytes({
    required BuildContext context,
    required Widget widget,
    required Size logicalSize,
  }) async {
    final boundaryKey = GlobalKey();
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (overlayContext) {
        return Positioned(
          left: -logicalSize.width * 2,
          top: 0,
          width: logicalSize.width,
          height: logicalSize.height,
          child: RepaintBoundary(
            key: boundaryKey,
            child: widget,
          ),
        );
      },
    );

    final overlay = Overlay.of(context);
    overlay.insert(entry);

    try {
      await WidgetsBinding.instance.endOfFrame;
      await WidgetsBinding.instance.endOfFrame;

      final boundary =
          boundaryKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        throw StateError('Render boundary not found');
      }

      final image = await boundary.toImage(pixelRatio: _pixelRatio);
      try {
        final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        if (byteData == null) {
          throw StateError('Failed to encode PNG');
        }
        return byteData.buffer.asUint8List();
      } finally {
        image.dispose();
      }
    } finally {
      entry.remove();
    }
  }
}
