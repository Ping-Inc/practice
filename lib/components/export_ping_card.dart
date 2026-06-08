import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/extensions/color_extensions.dart';
import 'package:practice/extensions/font_enum_extensions.dart';

class ExportPingCard extends StatelessWidget {
  const ExportPingCard({
    super.key,
    required this.ping,
    required this.latestPingId,
    required this.baseColor,
  });

  final PingData ping;
  final int latestPingId;
  final Color baseColor;

  static const double width = 852;
  static const double height = 922;
  static const double _cornerRadius = 40;
  static const double _horizontalInset = 52;
  static const double _verticalInset = 40;
  static const double _metadataFontSize = 24;
  static const double _bodyStartingFontSize = 140;

  String get _dateLabel {
    return DateFormat('EEEE, MMMM d, y').format(ping.time);
  }

  String get _idLabel {
    final formatter = NumberFormat.decimalPattern();
    final current = formatter.format(ping.id);
    final latest = formatter.format(latestPingId);
    return 'Ping $current of $latest';
  }

  @override
  Widget build(BuildContext context) {
    final metadataStyle = TextStyle(
      fontFamily: FontEnum.sfpro.toFontFamily(),
      fontSize: _metadataFontSize,
      color: baseColor.secondary,
      height: 1.0,
    );

    final bodyStyle = TextStyle(
      fontFamily: FontEnum.garamond.toFontFamily(),
      fontSize: _bodyStartingFontSize,
      color: baseColor.primary,
      height: lineHeight,
    );

    return Material(
      type: MaterialType.transparency,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: baseColor.ping,
            borderRadius: BorderRadius.circular(_cornerRadius),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: _horizontalInset,
              vertical: _verticalInset,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(child: Text(_dateLabel, style: metadataStyle)),
                Expanded(
                  child: Center(
                    child: AutoSizeText(
                      ping.text,
                      minFontSize: 1,
                      maxLines: null,
                      textAlign: TextAlign.left,
                      style: bodyStyle,
                    ),
                  ),
                ),
                Center(child: Text(_idLabel, style: metadataStyle)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
