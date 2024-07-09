import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:practice/constants.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/extensions/font_enum_extensions.dart';

class ResizingTextCell extends StatelessWidget {
  const ResizingTextCell(
      {super.key, required this.text, this.color = Colors.grey});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
            width: line,
          ),
        ),
        padding: EdgeInsets.all(spacingFour),
        child: Center(
            child: AutoSizeText(
          minFontSize: 1,
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              height: 1.5,
              fontSize: 200,
              fontFamily: FontEnum.sfpro.toFontFamily()),
        )));
  }
}
