import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/extensions/font_enum_extensions.dart';

class ResizingText extends StatelessWidget {
  const ResizingText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1,
        child: Center(
            child: AutoSizeText(
          minFontSize: 1,
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              height: 1.33,
              fontSize: 200,
              fontFamily: FontEnum.sfpro.toFontFamily()),
        )));
  }
}
