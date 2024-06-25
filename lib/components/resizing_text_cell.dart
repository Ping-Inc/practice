import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:practice/constants.dart';

class ResizingTextCell extends StatelessWidget {
  const ResizingTextCell({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary,
            width: line,
          ),
        ),
        padding: EdgeInsets.all(spacingFour),
        child: Center(
            child: AutoSizeText(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 200),
        )));
  }
}
