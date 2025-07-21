import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:practice/data/ping_data.dart';

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
  
  Future<void> share(BuildContext context) async {
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    final Rect sharePositionOrigin = box != null 
        ? box.localToGlobal(Offset.zero) & box.size
        : Rect.zero;

    await Share.share(
      formattedForSharing,
      sharePositionOrigin: sharePositionOrigin,
    );
  }
}