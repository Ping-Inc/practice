import 'package:flutter/material.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/font_enum.dart';

class ActiveDevelopment extends StatelessWidget {
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(spacingEight),
        child: Center(
          child: SystemText(
              align: TextAlign.center,
              font: FontEnum.sfmono,
              text: 'This page is in active development, check back soon..'),
        ));
  }
}
