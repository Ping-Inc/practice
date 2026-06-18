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

  static const double width = 360;
  static const double height = 640;
  static const double _cardWidth = 284;
  static const double _cardHeight = 307;
  static const double _cornerRadius = 13;
  static const double _horizontalInset = 17;
  static const double _verticalInset = 13;
  static const double _metadataFontSize = 8;
  static const double _bodyFontSize = 22;

  String get _dateLabel {
    final weekday = DateFormat('EEE').format(ping.time);
    final date = DateFormat('MMMM d, y').format(ping.time);
    final time = DateFormat('h:mma').format(ping.time).toLowerCase();
    return '$weekday. $date • $time';
  }

  String get _idLabel {
    final formatter = NumberFormat.decimalPattern();
    return '#${formatter.format(ping.id)}';
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
      fontSize: _bodyFontSize,
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
          color: baseColor.background,
          child: Center(
            child: Container(
              width: _cardWidth,
              height: _cardHeight,
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
                    Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: AutoSizeText(
                          ping.text,
                          minFontSize: 1,
                          maxLines: null,
                          textAlign: TextAlign.left,
                          style: bodyStyle,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_dateLabel, style: metadataStyle),
                        Text(_idLabel, style: metadataStyle),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
